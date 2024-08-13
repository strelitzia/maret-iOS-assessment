import UIKit

class AboutViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerStack: UIStackView!
    var engineer: Engineer?
    var engineersManager: EngineersManager?

    static func loadController(with engineer: Engineer, engineersManager: EngineersManager) -> AboutViewController {
        let viewController = AboutViewController.init(nibName: String.init(describing: self), bundle: Bundle(for: self))
        viewController.loadViewIfNeeded()
        viewController.engineersManager = engineersManager
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
        addProfileCardView()
        
        for question in engineer.questions {
            addQuestion(with: question)
        }
    }
    
    private func addProfileCardView() {
        guard let engineer, let profileView = ProfileCardView.loadView() else {
            return
        }
        
        profileView.setUp(engineer: engineer) { [weak self] in
            self?.presentImagePicker()
        }
        containerStack.addArrangedSubview(profileView)
    }
    
    private func addQuestion(with question: Question) {
        guard let cardView = QuestionCardView.loadView() else { return }
        cardView.setUp(
            with: question.questionText,
            options: question.answerOptions,
            selectedIndex: question.answer?.index
        ) { [weak self] answer in
            guard let self, let engineersManager = self.engineersManager, let engineer = self.engineer else {
                return
            }
            engineersManager.update(engineer: engineer, question: question, answer: answer)
        }
        containerStack.addArrangedSubview(cardView)
    }
}

extension AboutViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    private func presentImagePicker() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        self.present(pickerController, animated: true)
    }
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if let profileImage = info[.originalImage] as? UIImage {
            if let profileView = containerStack.arrangedSubviews.first as? ProfileCardView {
                profileView.set(profileImage: profileImage)
            }
            if let engineer, let engineersManager {
                engineersManager.update(engineer: engineer, profilePicture: profileImage)
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil) 
    }
}
