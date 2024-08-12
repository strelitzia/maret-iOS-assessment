protocol OrderByDelegate {
    func didSelectOrder(_ option: OrderOption)
}

enum OrderOption: String {
    case years = "Years"
    case coffees = "Coffees"
    case bugs = "Bugs"
}
