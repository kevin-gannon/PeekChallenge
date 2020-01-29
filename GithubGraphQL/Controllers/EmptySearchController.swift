import UIKit
import RxSwift
import RxCocoa

class EmptySearchController: UIViewController {
    @IBOutlet weak var yConstraint: NSLayoutConstraint!
    
    private var searchTerm: String = ""
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.hero.navigationAnimationType = .fade
        
        addBindings()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ServiceController {
            destination.viewModel = ServiceViewModel(
                RepositoryService(),
                searchTerm
            )
        }
        
        super.prepare(for: segue, sender: sender)
    }
    
    @IBAction func didTap(_ sender: Any) {
        UIApplication.shared.sendAction(
            #selector(SearchController.dismissAction),
            to: nil,
            from: self,
            for: nil
        )
    }
    
    private func addBindings() {
        Observable
        .from([
            NotificationCenter.default
                .rx.notification(UIResponder.keyboardWillShowNotification)
                .map { notification -> CGFloat in
                    (notification.userInfo?[
                        UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
                    )?.cgRectValue.height ?? 0
            },
            NotificationCenter.default
                .rx.notification(UIResponder.keyboardWillHideNotification)
                .map { _ -> CGFloat in 0 }
        ])
        .merge()
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: {[weak self] (keyboardHeight) in
            let offset = (keyboardHeight / 2.0)
            self?.yConstraint.constant = -offset
            UIView.animate(withDuration: 0.3) {[weak self] in
                self?.view.layoutIfNeeded()
            }
        })
        .disposed(by: disposeBag)
    }
}

extension EmptySearchController: SearchControllerDelegate {
    func didSearch(_ term: String) {
        searchTerm = term
        performSegue(withIdentifier: "Service", sender: nil)
    }
}

