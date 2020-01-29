import UIKit
import RxSwift
import RxCocoa

class ErrorController: UIViewController, ServiceViewModelDelegate  {
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var tryAgainButton: CommonButton!
        
    var serviceViewModel: ServiceViewModel!
    
    private var searchText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        errorLabel.hero.modifiers = [.fade, .duration(0.5)]
        tryAgainButton.hero.modifiers = [.fade, .duration(0.5)]
    }
    
    @IBAction func tryAgain(_ sender: Any) {
        if let text = searchText {
            serviceViewModel.updateQuery(text)
            return
        }
        
        serviceViewModel.tryAgain()
    }
}

extension ErrorController: SearchControllerDelegate {
    func didSearch(_ term: String) {
        serviceViewModel.updateQuery(term)
    }
    
    func textDidChange(_ searchText: String) {
        self.searchText = searchText
    }
}
