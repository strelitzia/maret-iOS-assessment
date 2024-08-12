import UIKit

class QuestionsViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerStack: UIStackView!
    var questions: [Question] = []
    var engineer: Engineer?
    
    static func loadController(with questions: [Question], engineer: Engineer) -> QuestionsViewController {
        let viewController = QuestionsViewController.init(nibName: String.init(describing: self), bundle: Bundle(for: self))
        viewController.loadViewIfNeeded()
        viewController.setUp(with: questions, engineer: engineer)
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

    func setUp(with questions: [Question], engineer: Engineer) {
        loadViewIfNeeded()

        addProfileView(engineer: engineer)
        
        for question in questions {
            addQuestion(with: question)
        }

        self.questions = questions
    }
    
    private func addProfileView(engineer: Engineer) {
        guard let profileView = ProfileCardView.loadView() else {
            return
        }
        self.engineer = engineer
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
