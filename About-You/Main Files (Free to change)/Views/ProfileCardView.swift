import UIKit

class ProfileCardView: UIView {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var numbersView: UIView!
    @IBOutlet weak var bugsLabel: UILabel!
    @IBOutlet weak var coffeesLabel: UILabel!
    @IBOutlet weak var yearsLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    
    @IBOutlet weak var profileView: UIImageView!
    
    override func awakeFromNib() {
        applyStyling()
    }
    
    func setUp(engineer: Engineer) {
        nameLabel.text = engineer.name
        roleLabel.text = engineer.role
        bugsLabel.text = "\(engineer.quickStats.bugs)"
        coffeesLabel.text = "\(engineer.quickStats.coffees)"
        yearsLabel.text = "\(engineer.quickStats.years)"
        quoteLabel.text = "\"\(engineer.quote)\""
    }
   
    private func applyStyling() {
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.semibold)
        quoteLabel.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold)
        roleLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        roleLabel.textColor = .white
        quoteLabel.textColor = .white
        
        numbersView.backgroundColor = .white
        numbersView.layer.cornerRadius = 10
        numbersView.layer.cornerCurve = .continuous
        bugsLabel.textColor = .black
        coffeesLabel.textColor = .black
        yearsLabel.textColor = .black
        
        layer.cornerRadius = 10
        layer.cornerCurve = .continuous
    }
    
    static func loadView() -> Self? {
        let bundle = Bundle(for: self)
        let views = bundle.loadNibNamed(String(describing: self), owner: nil, options: nil)
        guard let view = views?.first as? Self else {
            return nil
        }
        return view
    }
}

