import UIKit
import AlamofireImage

struct RepositoryCellViewModel {
    private let details: RepositoryDetails
    
    var titleText: String {
        return details.name
    }
    
    var owner: String {
        return details.owner.login
    }
    
    var url: String {
        return details.url
    }
    
    var avatar: String {
        return details.owner.avatarUrl
    }
    
    var starCount: String {
        var stars = CGFloat(details.stargazers.totalCount)
        
        if stars < 1000 { return "\(details.stargazers.totalCount)" }
        
        stars = stars / 1000
        
        var formatted = String(format: "%.1f",stars)
        
        if formatted.last == "0" {
            formatted = String(formatted.dropLast(2))
        }
        
        return "\(formatted)K"
    }
    
    init(_ details: RepositoryDetails) {
        self.details = details
    }
}

class RepositoryCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var starContainer: Star!
    @IBOutlet weak var starCountLabel: UILabel!
    
    func setRepository(_ viewModel: RepositoryCellViewModel) {
        titleLabel.text = viewModel.titleText
        ownerLabel.text = viewModel.owner
        starCountLabel.text = viewModel.starCount
        avatar.image = nil
        
        if let url = URL(string: viewModel.avatar) {
            avatar.af_setImage(withURL: url)
        }
    }
}

