import SwiftUI
import UIKit

struct MovieDetailView: View {
    var movie: Movie
    @ObservedObject var viewModel: ViewModel
    @ObservedObject var favorites = FavoritesStore.shared
    @ObservedObject var watchlist = FavoritesStore.shared
    
    init(movie: Movie) {
        self.movie = movie
        self.viewModel = ViewModel(movie: movie)
    }
    
    var body: some View {
        VStack {
            Text(movie.title)
                .font(.largeTitle)
            Text("Original title / language : \(movie.originalTitle) (\(movie.originalLanguage))")
            Text("Release date : \(movie.releaseDate)")
            Text("Note: \(String(format: "%.1f", movie.voteAverage)) / 10 (\(movie.voteCount) votes)")
            Text("Description : \(movie.overview)")
            
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit() // Garde le ratio
                    .frame(maxWidth: 300, maxHeight: 300) // Limite la taille
                    .padding()
            }
            
            // Bouton pour ajouter/retirer des favoris
            Button(action: {
                if favorites.contains(movie, in: favorites.favoriteMovies) {
                    favorites.remove(movie, from: &favorites.favoriteMovies)
                } else {
                    favorites.add(movie, to: &favorites.favoriteMovies)
                }
            }) {
                Image(systemName: favorites.contains(movie, in: favorites.favoriteMovies) ? "heart.fill" : "heart")
                    .foregroundColor(.red)
                    .font(.largeTitle)
            }
            
            // Bouton pour ajouter/retirer de la watchlist
            Button(action: {
                if watchlist.contains(movie, in: watchlist.watchlistMovies) {
                    watchlist.remove(movie, from: &watchlist.watchlistMovies)
                } else {
                    watchlist.add(movie, to: &watchlist.watchlistMovies)
                }
            }) {
                Image(systemName: watchlist.contains(movie, in: watchlist.watchlistMovies) ? "eye.fill" : "eye")
                    .foregroundColor(.blue)
                    .font(.largeTitle)
            }
        }
        .padding()
    }
}

#Preview {
    MovieDetailView(movie: Movie.mock) // Ajout de l'EnvironmentObject ici
}

extension MovieDetailView {
    
    class ViewModel: ObservableObject {
        
        var movie: Movie
        
        @Published var image: UIImage?
        
        init(movie: Movie) {
            self.movie = movie
            Task {
                let newImage = await self.fetchImage(movie.posterURL)
                DispatchQueue.main.async { self.image = newImage }
            }
        }
        
        func fetchImage(_ urlString: String) async -> UIImage? {
            guard let url = URL(string: urlString) else { return nil }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                return UIImage(data: data)
            } catch {
                print("Failed to fetch image: \(error)")
                return nil
            }
        }
    }
}
