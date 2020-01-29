import RxSwift
import RxCocoa
import UIKit

struct ContentViewModel {
    let repositories: BehaviorRelay<[RepositoryDetails]>
    let pageInfo: BehaviorRelay<PageInfo>
    let service: RepositoryService
    let pageSize: Int = 30
    let nextPage: BehaviorRelay<String>
    let disposeBag = DisposeBag()
    let query: String
    
    init(
        _ details: RepositorySearchResponse,
        _ service: RepositoryService,
        _ query: String) {
        self.pageInfo = BehaviorRelay<PageInfo>(value: details.pageInfo)
        self.service = service
        self.nextPage = BehaviorRelay<String>(value: "")
        self.query = query
        self.repositories = BehaviorRelay<[RepositoryDetails]>(value: details.repositories)

        addBindings()
    }
    
    func getNextPage() {
        guard let start = pageInfo.value.endCursor else { return }
        nextPage.accept(start)
    }
    
    private func addBindings() {
        nextPage
           .asObservable()
           .distinctUntilChanged()
           .skip(1)
           .flatMapLatest{ page -> Observable<APIResponse<RepositorySearchResponse>> in
            self.service.getRepositories(self.query, self.pageSize, page)
           }
           .subscribe{ next in
            guard let data = next.element?.data else { return }
            self.pageInfo.accept(data.pageInfo)
            self.repositories.accept([self.repositories.value, data.repositories].flatMap { $0 }
            )
        }
        .disposed(by: disposeBag)
    }
}
