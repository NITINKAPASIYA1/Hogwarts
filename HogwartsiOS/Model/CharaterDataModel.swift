
struct Character: Identifiable, Codable,Equatable {
    let id: String
    let name: String
    let species: String
    let gender: String
    let house: String
    let dateOfBirth: String?
    let hogwartsStaff: Bool
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, species, gender, house, dateOfBirth, hogwartsStaff, image
    }
}
