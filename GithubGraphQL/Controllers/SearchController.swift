import UIKit

protocol SearchControllerDelegate {
    func didSearch(_ term: String)
    func textDidChange(_ searchText: String)
}

extension SearchControllerDelegate {
    func textDidChange(_ searchText: String) {}
}

class SearchController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var childController: UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        navigationController?.hero.navigationAnimationType = .fade
    }
    
    @objc func dismissAction() {
        searchBar.resignFirstResponder()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UINavigationController {
            self.childController = destination
        }
        
        super.prepare(for: segue, sender: sender)
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        DispatchQueue.main.async {[weak self] in
            self?.searchBar.becomeFirstResponder()
        }
    }
}

extension SearchController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presentingViewController?.dismiss(animated: false, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            childController.popToRootViewController(animated: false)
            return
        }
        
        if
            let top = childController.topViewController,
            let delegate = top as? SearchControllerDelegate {
            delegate.textDidChange(searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let search = searchBar.text, !search.isEmpty else {
            searchBar.resignFirstResponder()
            return
        }
        if
            let top = childController.topViewController,
            let delegate = top as? SearchControllerDelegate {
            delegate.didSearch(search)
        }
        
        searchBar.resignFirstResponder()
    }
}
