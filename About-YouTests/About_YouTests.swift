import XCTest
@testable import About_You

class About_YouTests: XCTestCase {
    func test_engineerArraySortByCoffees() {
        let one = createEngineer(name: "one", coffees: 8)
        let two = createEngineer(name: "two", coffees: 800)
        let three = createEngineer(name: "three", coffees: 80)
        let four = createEngineer(name: "four", bugs: 18)
        let array = [one, two, three, four]
        let result = array.orderBy(by: .coffees)
        XCTAssertEqual(result.count, array.count)
        XCTAssertEqual(result.first?.name, two.name)
        XCTAssertEqual(result[1].name, four.name)
        XCTAssertEqual(result[2].name, three.name)
        XCTAssertEqual(result.last?.name, one.name)
    }
    
    func testSortByBugs() {
        let one = createEngineer(name: "one", bugs: 8)
        let two = createEngineer(name: "two", bugs: 800)
        let three = createEngineer(name: "three", bugs: 80)
        let four = createEngineer(name: "four", bugs: 88)
        let array = [one, two, three, four]
        let result = array.orderBy(by: .bugs)
        XCTAssertEqual(result.count, array.count)
        XCTAssertEqual(result.first?.name, two.name)
        XCTAssertEqual(result[1].name, four.name)
        XCTAssertEqual(result[2].name, three.name)
        XCTAssertEqual(result.last?.name, one.name)
    }
    
    func testSortByYears() {
        let one = createEngineer(name: "one", years: 99)
        let two = createEngineer(name: "two", years: 93)
        let three = createEngineer(name: "three", years: 900)
        let four = createEngineer(name: "four", years: 108)
        let array = [one, two, three, four]
        let result = array.orderBy(by: .years)
        XCTAssertEqual(result.count, array.count)
        XCTAssertEqual(result.first?.name, three.name)
        XCTAssertEqual(result[1].name, four.name)
        XCTAssertEqual(result[2].name, one.name)
        XCTAssertEqual(result.last?.name, two.name)
    }
    
    private func createEngineer(name: String,
                        years: Int = 99,
                        coffees: Int = 99,
                        bugs: Int = 99,
                        questions: [Question] = []) -> Engineer {
        Engineer(name: name,
                 role: "developer",
                 defaultImageName: "",
                 quickStats: .init(years: years, coffees: coffees, bugs: bugs),
                 questions: questions, 
                 quote: "walking about")
    }
    
}
