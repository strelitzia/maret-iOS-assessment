import UIKit

class GlucodianTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUp(with engineer: Engineer) {
        nameLabel.text = engineer.name
        roleLabel.text = engineer.role
        if let imageName = engineer.imageName, let image =  UIImage(named: imageName) {
            profileImage.image = image
        }
    }
}
