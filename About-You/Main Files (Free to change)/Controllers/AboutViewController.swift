import UIKit

class AboutViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerStack: UIStackView!
    var engineer: Engineer?
    
    static func loadController(with engineer: Engineer) -> AboutViewController {
        let viewController = AboutViewController.init(nibName: String.init(describing: self), bundle: Bundle(for: self))
        viewController.loadViewIfNeeded()
        viewController.setUp(engineer: engineer)
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "About"
        scrollView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }

    func setUp(engineer: Engineer) {
        loadViewIfNeeded()
        self.engineer = engineer
        addProfileView(engineer: engineer)
        
        for question in engineer.questions {
            addQuestion(with: question)
        }
    }
    
    private func addProfileView(engineer: Engineer) {
        guard let profileView = ProfileCardView.loadView() else {
            return
        }
        
        profileView.setUp(engineer: engineer)
        containerStack.addArrangedSubview(profileView)
    }

    private func addQuestion(with data: Question) {
        guard let cardView = QuestionCardView.loadView() else { return }
        cardView.setUp(with: data.questionText,
                       options: data.answerOptions,
                       selectedIndex: data.answer?.index)
        containerStack.addArrangedSubview(cardView)
    }
}
