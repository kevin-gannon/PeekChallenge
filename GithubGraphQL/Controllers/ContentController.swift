import UIKit
import RxSwift
import RxCocoa

class ContentController: UITableViewController,
                         ContentViewModelDelegate {
    
    var viewModel: ContentViewModel!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
       super.viewDidLoad()
               
       addBindings()
    }
    
    private func addBindings() {
        viewModel.repositories
            .asObservable()
            .bind(to: tableView.rx.items(
                cellIdentifier: "RepositoryCell",
                cellType: RepositoryCell.self)) { index, repo, cell in
                    cell.hero.modifiers = [.fade, .translate(y:50)]
                    if cell.starContainer.subviews.isEmpty {
                        let star = Star(frame: CGRect(
                            x: 0,
                            y: 0,
                            width: 20,
                            height: 20
                        ))
                        star.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                        cell.starContainer.addSubview(star)
                        star.center = CGPoint(x: 10, y: 10)
                    }
                    let viewmodel = RepositoryCellViewModel(repo)
                    cell.setRepository(viewmodel)
            }
        .disposed(by: disposeBag)
        
        tableView.rx.contentOffset
            .asObservable()
            .subscribe{[weak self] next in
                guard let ss = self, let e = next.element else { return }
                let marker = ss.tableView.contentSize.height / 2.0
                if e.y + ss.tableView.bounds.size.height > marker {
                    self?.viewModel.getNextPage()
                }
        }
        .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: {[weak self] idx in
                guard let ss = self else { return }
                let str = ss.viewModel.repositories.value[idx.row].url
                if let url = URL(string: str) {
                    UIApplication.shared.open(url)
                }
        }).disposed(by: disposeBag)
    }
}
