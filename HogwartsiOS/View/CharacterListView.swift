

import SwiftUI

struct CharacterListView: View {
    @StateObject private var viewModel = CharacterListViewModel()
    let house: String
    
    var body: some View {
        VStack {
            //Yeh heading h
            Text("\(house.capitalized) Characters")
                .font(.title)
                .fontWeight(.bold)
                .padding()
                .background(Color(houseColor))
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.top, 100)
            
            //Yeh Scrollable Content h
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(viewModel.characters) { character in
                        CharacterCardView(character: character, house: house)
                            .padding(.horizontal)
                            .onAppear {
                                // Load more characters when the last one appears
                                if character == viewModel.characters.last {
                                    viewModel.loadMoreCharacters(house: house)
                                }
                            }
                    }
                    if viewModel.isLoading {
                        ProgressView().padding()
                    }
                }
                .padding(.bottom, 20)
            }
            .onAppear {
                viewModel.fetchCharacters(house: house)
            }
            .refreshable {
                viewModel.refreshCharacters(house: house)
            }
        }
        .padding(.horizontal)
        .background(Color(UIColor.systemGroupedBackground))
        .ignoresSafeArea(edges: .top)
    }
    
    // Function to determine color based on the house
    var houseColor: UIColor {
        switch house.lowercased() {
        case "gryffindor": return UIColor.systemRed
        case "slytherin": return UIColor.systemGreen
        case "hufflepuff": return UIColor.systemYellow
        case "ravenclaw": return UIColor.systemBlue
        default: return UIColor.systemGray
        }
    }
}

struct CharacterCardView: View {
    let character: Character
    let house: String
    
    var body: some View {
        VStack {
            
            Text(character.name)
                .font(.headline)
                .fontWeight(.bold)
                .padding()
                .background(Color(houseColor))
                .foregroundColor(.white)
                .cornerRadius(5)
                .frame(maxWidth: .infinity)
            
           
            AsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 200)
                    .clipped()
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
                    .frame(width: 150, height: 200)
            }
            .padding(.vertical, 8)
            
            // Character Details Grid
            VStack(spacing: 10) {
                HStack {
                    Text("Species:")
                        .fontWeight(.semibold)
                    Spacer()
                    Text(character.species)
                }
                HStack {
                    Text("Gender:")
                        .fontWeight(.semibold)
                    Spacer()
                    Text(character.gender)
                }
                HStack {
                    Text("House:")
                        .fontWeight(.semibold)
                    Spacer()
                    Text(character.house)
                        .foregroundColor(Color(houseColor))
                        .fontWeight(.bold)
                }
                if let dob = character.dateOfBirth {
                    HStack {
                        Text("Date of Birth:")
                            .fontWeight(.semibold)
                        Spacer()
                        Text(dob)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
        .padding()
        .background(Color(houseBackgroundColor))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
    
   
    var houseColor: Color {
        switch house.lowercased() {
        case "gryffindor": return .red
        case "slytherin": return .green
        case "hufflepuff": return .yellow
        case "ravenclaw": return .blue
        default: return .gray
        }
    }
    
    var houseBackgroundColor: Color {
        switch house.lowercased() {
        case "gryffindor": return Color.red.opacity(0.2)
        case "slytherin": return Color.green.opacity(0.2)
        case "hufflepuff": return Color.yellow.opacity(0.2)
        case "ravenclaw": return Color.blue.opacity(0.2)
        default: return Color.gray.opacity(0.2)
        }
    }
}
