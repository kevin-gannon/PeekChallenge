import UIKit
import RxSwift
import RxCocoa

protocol ContentViewModelDelegate {
    var viewModel: ContentViewModel! { get set }
}

class HomeController: ContentController {
    override func viewDidLoad() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
           
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.hero.navigationAnimationType = .fade
        
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = 100.0
        tableView.hero.modifiers = [.cascade]
        tableView.dataSource = nil
        tableView.delegate = nil
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    @IBAction func cancel(_ unwindSegue: UIStoryboardSegue) {}
}

extension HomeController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        performSegue(withIdentifier: "Search", sender: nil)
        return false
    }
}
