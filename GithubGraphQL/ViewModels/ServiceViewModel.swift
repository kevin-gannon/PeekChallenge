import RxSwift
import RxCocoa
import UIKit

struct ServiceViewModel {
    let service: RepositoryService
    let disposeBag = DisposeBag()
    let nextUIEvent = PublishSubject<UIEvent>()
    let tryAgainSubject = PublishSubject<Void>()
    let minTime = PublishSubject<Void>()
    let minWaitTime: Double = 1.0
    let content = BehaviorRelay<ContentViewModel?>(value: nil)
    let query: BehaviorRelay<String>
    let searchResponse: Observable<APIResponse<RepositorySearchResponse>>
    let pageSize = 30

    private let _nextUIEvent = PublishSubject<UIEvent>()
    
    struct Strings {
        static let homeErrorSegue = "Error"
        static let homeContentSegue = "Content"
    }

    init(_ service: RepositoryService, _ query: String = "graphql") {
        self.service = service
        self.query = BehaviorRelay<String>(value: query)
        self.searchResponse = service.getRepositories(query, pageSize)
        
        addBindings()
    }
    
    func updateQuery(_ name: String) {
        query.accept(name)
    }

    func tryAgain() {
        tryAgainSubject.onNext(())
    }

    private func addBindings() {
        DispatchQueue.main.asyncAfter(deadline: .now() + minWaitTime) {
            self.minTime.onNext(())
        }
        
        searchResponse
            .map { response -> ContentViewModel? in
                guard
                    let data = response.data,
                    !data.repositories.isEmpty else { return nil }
                return ContentViewModel(data, self.service, self.query.value)
            }
            .bind(to: content)
            .disposed(by: disposeBag)

        Observable
            .zip(_nextUIEvent.asObservable(), minTime.asObservable()) {
                (event, _) -> UIEvent in return event
            }
            .subscribe(onNext: { next in self.nextUIEvent.onNext(next) })
            .disposed(by: disposeBag)
        
        content.asObservable()
            .skip(1)
            .take(1)
            .subscribe(onNext: { next in
                self._nextUIEvent.onNext(.segue(id: next == nil
                    ? Strings.homeErrorSegue
                    : Strings.homeContentSegue
            ))
        }).disposed(by: disposeBag)
    }
}
