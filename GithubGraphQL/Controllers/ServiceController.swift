import UIKit
import Hero
import RxCocoa
import RxSwift

protocol ServiceViewModelDelegate {
    var serviceViewModel: ServiceViewModel! { get set }
}

class ServiceController: UIViewController {
    var viewModel: ServiceViewModel!
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var loaderView: LoaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if viewModel == nil { viewModel = ServiceViewModel(RepositoryService()) }
        
        loaderView.alpha = 0
                
        addBindings()

        navigationController?.hero.navigationAnimationType = .fade
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.2, animations: {[weak self] in
            self?.loaderView.alpha = 1.0
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { 
        if var destination = segue.destination as? ContentViewModelDelegate {
            destination.viewModel = viewModel.content.value
        }
            
        if var destination = segue.destination as? ServiceViewModelDelegate {
            destination.serviceViewModel = viewModel
        }
        
        super.prepare(for: segue, sender: sender)
    }
    
    private func addBindings() {
        viewModel.tryAgainSubject
            .asObservable()
            .subscribe(onNext: {[weak self] next in
                guard let ss = self else { return }
                let query = ss.viewModel.query.value
                ss.disposeBag = DisposeBag()
                ss.viewModel = ServiceViewModel(RepositoryService(),query)
                ss.addBindings()
                ss.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        viewModel.query
            .asObservable()
            .skip(1)
            .subscribe(onNext: {[weak self] next in
                self?.disposeBag = DisposeBag()
                self?.viewModel = ServiceViewModel(RepositoryService(),next)
                self?.addBindings()
                self?.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        viewModel.nextUIEvent
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] next in
                switch next {
                case .segue(let id):
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.loaderView.alpha = 0.0
                    }, completion: { _ in
                        self?.performSegue(withIdentifier: id, sender: nil)
                })
            }
        }).disposed(by: disposeBag)
    }
}
