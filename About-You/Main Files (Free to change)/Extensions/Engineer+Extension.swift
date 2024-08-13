extension Array where Element == Engineer {
    func orderBy(by orderOption: OrderOption) -> [Engineer] {
        switch orderOption {
        case .years:
            self.sorted { engineerA, engineerB in
                return engineerA.quickStats.years > engineerB.quickStats.years
            }
        case .coffees:
            self.sorted { engineerA, engineerB in
                return engineerA.quickStats.coffees > engineerB.quickStats.coffees
            }
        case .bugs:
            self.sorted { engineerA, engineerB in
                return engineerA.quickStats.bugs > engineerB.quickStats.bugs
            }
        }
    }
}
