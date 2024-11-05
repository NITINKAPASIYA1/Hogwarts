import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = HouseViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hogwarts Houses")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(viewModel.houses) { house in
                        NavigationLink(destination: CharacterListView(house: house.name.lowercased())) {
                            HouseItemView(house: house)
                        }
                    }
                }
                .padding()
            }
        }
    }
}


struct HouseItemView: View {
    let house: House
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: house.imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            } placeholder: {
                ProgressView()
            }
            
            Text(house.name)
                .font(.headline)
                .padding(.top, 5)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}
