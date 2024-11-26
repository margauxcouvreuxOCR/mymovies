import Foundation

class FavoritesStore: ObservableObject {
    
    @Published var favoriteMovies: [Movie] = [] {
        didSet {
            saveList(favoriteMovies, forKey: favoritesKey)
        }
    }
    
    @Published var watchlistMovies: [Movie] = [] {
        didSet {
            saveList(watchlistMovies, forKey: watchlistKey)
        }
    }
    
    private let favoritesKey: String
    private let watchlistKey: String

    init(favoritesKey: String, watchlistKey: String) {
        self.favoritesKey = favoritesKey
        self.watchlistKey = watchlistKey
        self.loadLists()
    }
    
    // Ajouter un film à une liste
    func add(_ movie: Movie, to list: inout [Movie]) {
        if !list.contains(where: { $0.id == movie.id }) {
            list.append(movie)
        }
    }
    
    // Retirer un film d'une liste
    func remove(_ movie: Movie, from list: inout [Movie]) {
        list.removeAll { $0.id == movie.id }
    }
    
    // Vérifier si un film est dans une liste
    func contains(_ movie: Movie, in list: [Movie]) -> Bool {
        return list.contains(where: { $0.id == movie.id })
    }
    
    // Sauvegarder une liste
    private func saveList(_ list: [Movie], forKey key: String) {
        if let encoded = try? JSONEncoder().encode(list) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    // Charger les listes
    private func loadLists() {
        if let favoritesData = UserDefaults.standard.data(forKey: favoritesKey),
           let decodedFavorites = try? JSONDecoder().decode([Movie].self, from: favoritesData) {
            favoriteMovies = decodedFavorites
        }
        
        if let watchlistData = UserDefaults.standard.data(forKey: watchlistKey),
           let decodedWatchlist = try? JSONDecoder().decode([Movie].self, from: watchlistData) {
            watchlistMovies = decodedWatchlist
        }
    }
}

extension FavoritesStore {
    static let shared = FavoritesStore(favoritesKey: "favoriteMovies", watchlistKey: "watchlistMovies")
}

