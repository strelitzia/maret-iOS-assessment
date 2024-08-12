import UIKit

class OrderByTableViewController: UITableViewController {
    var delegate: OrderByDelegate?
    var orderOptions: [OrderOption] = [.years, .coffees, .bugs]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderOptions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self))
        guard let cell, indexPath.row < orderOptions.count else {
            return cell ?? UITableViewCell()
        }
        cell.textLabel?.text = orderOptions[indexPath.row].rawValue
        cell.accessoryType = .none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate, indexPath.row < orderOptions.count else {
            return
        }
        
        for cell in tableView.visibleCells {
            cell.accessoryType = .none
        }
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        delegate.didSelectOrder(orderOptions[indexPath.row])
    }

}
