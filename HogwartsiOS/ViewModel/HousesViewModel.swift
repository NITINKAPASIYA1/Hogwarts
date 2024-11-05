import Foundation

class HouseViewModel: ObservableObject {
    @Published var houses: [House] = [
        House(name: "Gryffindor", imageUrl: "https://i.imghippo.com/files/Zz06c1728466625.jpg"),
        House(name: "Slytherin", imageUrl: "https://i.imghippo.com/files/qBe0v1728466743.jpg"),
        House(name: "Ravenclaw", imageUrl: "https://i.imghippo.com/files/dNdZD1728466888.jpg"),
        House(name: "Hufflepuff", imageUrl: "https://i.imghippo.com/files/zlDEL1728466864.jpg")
    ]
}
