import XCTest
@testable import About_You

class About_YouTests: XCTestCase {
    func test_engineerManager_OrderByCoffees() {
        let one = createEngineer(name: "one", coffees: 8)
        let two = createEngineer(name: "two", coffees: 800)
        let three = createEngineer(name: "three", coffees: 80)
        let four = createEngineer(name: "four", bugs: 18)

        let sut = EngineersManager(engineers: [one, two, three, four])
        sut.orderEngineers(by: .coffees)
        XCTAssertEqual(sut.engineers.first?.name, two.name)
        XCTAssertEqual(sut.engineers[1].name, four.name)
        XCTAssertEqual(sut.engineers[2].name, three.name)
        XCTAssertEqual(sut.engineers.last?.name, one.name)
    }
    
    func test_engineerManager_OrderByBugs() {
        let one = createEngineer(name: "one", bugs: 8)
        let two = createEngineer(name: "two", bugs: 800)
        let three = createEngineer(name: "three", bugs: 80)
        let four = createEngineer(name: "four", bugs: 88)
        let sut = EngineersManager(engineers: [one, two, three, four])
        sut.orderEngineers(by: .bugs)
        XCTAssertEqual(sut.engineers.first?.name, two.name)
        XCTAssertEqual(sut.engineers[1].name, four.name)
        XCTAssertEqual(sut.engineers[2].name, three.name)
        XCTAssertEqual(sut.engineers.last?.name, one.name)
    }
    
    func test_engineerManager_OrderByYears() {
        let one = createEngineer(name: "one", years: 99)
        let two = createEngineer(name: "two", years: 93)
        let three = createEngineer(name: "three", years: 900)
        let four = createEngineer(name: "four", years: 108)
        let sut = EngineersManager(engineers: [one, two, three, four])
        sut.orderEngineers(by: .years)
        XCTAssertEqual(sut.engineers.first?.name, three.name)
        XCTAssertEqual(sut.engineers[1].name, four.name)
        XCTAssertEqual(sut.engineers[2].name, one.name)
        XCTAssertEqual(sut.engineers.last?.name, two.name)
    }
    
    func test_engineersManager_updateQuestionAnswerInList() {
        let initialAnswer = Answer(text: "Something", index: 0)
        let question = Question(
            questionText: "what is your favourite song?",
            answerOptions: ["Something", "Let It Be", "Hey Jude"],
            questionType: .selection,
            answer: initialAnswer
        )
        let john = createEngineer(name: "John", questions: [question])
        let engineers = [john, createEngineer(name: "Paul")]
        let sut = EngineersManager(engineers: engineers)
        
        // Verify before we change
        let currentAnswer = sut.engineers.first(where: {$0.employeeID == john.employeeID})?.questions.first?.answer
        XCTAssertEqual(currentAnswer?.index, initialAnswer.index)
        XCTAssertEqual(currentAnswer?.text, initialAnswer.text)
        
        let expectedAnswer = Answer(text: "Let It Be", index: 2)
        // Update the question answer.
        sut.update(engineer: john, question: question, answer: expectedAnswer)
        
        let newAnswer = sut.engineers.first(where: {$0.employeeID == john.employeeID})?.questions.first?.answer
        XCTAssertEqual(newAnswer?.index, expectedAnswer.index)
        XCTAssertEqual(newAnswer?.text, expectedAnswer.text)
    }
    
    func test_engineersManager_updateEmptyProfileImage() {
        let george = createEngineer(name: "George", profileImage: nil)
        let ringo = createEngineer(name: "Ringo", profileImage: nil)
        let sut = EngineersManager(engineers: [george, ringo])
        
        guard let image =  UIImage(systemName: "person.fill") else {
            XCTFail("The Image creation should not fail")
            return
        }
        
        sut.update(engineer: george, profileImage: image)
        XCTAssertEqual(sut.engineers.first?.profileImage, image)
    }
    
    func test_engineersManager_updateExistingProfileImageToAnotherImage() {
        guard let oldImage = UIImage(systemName: "person.fill"),
        let newProfileImage = UIImage(systemName: "eraser") else {
            XCTFail("The Image creation should not fail")
            return
        }
        let george = createEngineer(name: "George", profileImage: oldImage)
        let ringo = createEngineer(name: "Ringo", profileImage: nil)
        let sut = EngineersManager(engineers: [george, ringo])
        
        XCTAssertEqual(sut.engineers.first?.profileImage, oldImage)
        
        sut.update(engineer: george, profileImage: newProfileImage)
        XCTAssertEqual(sut.engineers.first?.profileImage, newProfileImage)
    }
    
    private func createEngineer(
        name: String,
        years: Int = 99,
        coffees: Int = 99,
        bugs: Int = 99,
        profileImage: UIImage? = nil,
        questions: [Question] = []) -> Engineer {
            Engineer(
                employeeID: UUID().uuidString,
                name: name,
                role: "developer",
                profileImage: profileImage,
                quickStats: .init(years: years, coffees: coffees, bugs: bugs),
                questions: questions,
                quote: "walking about"
            )
        }
    
}
