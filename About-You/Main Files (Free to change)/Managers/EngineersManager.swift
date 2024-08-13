import UIKit
class EngineersManager {
    static var shared: EngineersManager = EngineersManager()
    
    var engineers: [Engineer]
    
    private init(engineers: [Engineer] = Engineer.testingData()) {
        self.engineers = engineers
    }
    
    func update(engineer: Engineer, profilePicture image: UIImage) {
        guard let index = engineers.firstIndex(where: {$0.employeeID == engineer.employeeID}) else {
            return
        }
        engineers[index].profileImage = image
    }

    func orderEngineers(by option: OrderOption) {
        engineers = engineers.orderBy(by: option)
    }
}
