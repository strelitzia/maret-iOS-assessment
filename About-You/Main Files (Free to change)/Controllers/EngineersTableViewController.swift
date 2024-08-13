import UIKit

class EngineersTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {

    var engineersManager: EngineersManager = .shared
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Engineers at Glucode"
        tableView.backgroundColor = .white
        registerCells()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        setupNavigationController()
    }

    private func setupNavigationController() {
        navigationController?.navigationBar.backgroundColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Order by",
            style: .plain,
            target: self,
            action: #selector(orderByTapped)
        )
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc func orderByTapped() {
        guard let from = navigationItem.rightBarButtonItem else { return }
        let controller = OrderByTableViewController(style: .plain)
        controller.delegate = self
        let size = CGSize(width: 200, height: 150)
        
        present(popover: controller,
                from: from,
                size: size,
                arrowDirection: .up)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    private func registerCells() {
        tableView.register(
            UINib(nibName: String(describing: GlucodianTableViewCell.self),bundle: nil),
            forCellReuseIdentifier: String(describing: GlucodianTableViewCell.self)
        )
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        engineersManager.engineers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GlucodianTableViewCell.self)) as? GlucodianTableViewCell else {
            return UITableViewCell()
        }
        cell.setUp(with: engineersManager.engineers[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = AboutViewController.loadController(
            with: engineersManager.engineers[indexPath.row],
            engineersManager: engineersManager
        )
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension EngineersTableViewController: OrderByDelegate {
    func didSelectOrder(_ option: OrderOption) {
        engineersManager.orderEngineers(by: option)
        self.tableView.reloadData()
    }
}
