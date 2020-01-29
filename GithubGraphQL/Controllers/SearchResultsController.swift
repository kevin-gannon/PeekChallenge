import UIKit
import RxSwift
import RxCocoa

class SearchResultsController: ContentController,
                               ServiceViewModelDelegate {
    
    var serviceViewModel: ServiceViewModel!
        
    override func viewDidLoad() {
        navigationController?.hero.navigationAnimationType = .fade
        
        tableView.hero.modifiers = [.cascade]
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = 100.0
        tableView.dataSource = nil
        tableView.delegate = nil
        
        super.viewDidLoad()
    }
}

extension SearchResultsController: SearchControllerDelegate {
    func didSearch(_ term: String) {
        serviceViewModel.updateQuery(term)
    }
}
