import SwiftUI
import Combine

class CharacterListViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading = false
    private var currentPage = 1
    private let pageSize = 10
    private var cache: [String: [Character]] = [:]
    private var allCharacters: [Character] = []
    
    //took some help from chatGPT for pagination part and refreshing
    func fetchCharacters(house: String, refresh: Bool = false) {
        if refresh {
            currentPage = 1
            characters = []
            cache[house] = nil
        }
        
        if let cachedCharacters = cache[house], !refresh {
            characters = cachedCharacters
            return
        }
        
        guard !isLoading else { return }
        isLoading = true
        
        guard let url = URL(string: "https://hp-api.herokuapp.com/api/characters/house/\(house)") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            do {
                self.allCharacters = try JSONDecoder().decode([Character].self, from: data)
                DispatchQueue.main.async {
                    self.loadPage(house: house)
                    self.isLoading = false
                }
            } catch {
                print("Failed to decode: \(error)")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }.resume()
    }
    
    func loadPage(house: String) {
        let start = (currentPage - 1) * pageSize
        let end = min(start + pageSize, allCharacters.count)
        
        if start < end {
            let newCharacters = Array(allCharacters[start..<end])
            characters.append(contentsOf: newCharacters)
            cache[house] = characters // Cache up to one page
            currentPage += 1
        }
    }
    
    func loadMoreCharacters(house: String) {
        guard !isLoading else { return }
        loadPage(house: house)
    }
    
    func refreshCharacters(house: String) {
        currentPage = 1
        characters = []
        cache[house] = nil // Clear the cache for the house
        fetchCharacters(house: house, refresh: true)
    }
}
