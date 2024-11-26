import SwiftUI

struct ContentView: View {
    @ObservedObject var store = FavoritesStore.shared
    
    var body: some View {
        TabView {
            NavigationStack {
                SearchMovieView()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Rechercher")
            }
            
            NavigationStack {
                List(store.favoriteMovies, id: \.id) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        MovieRowView(movie: movie)
                    }
                }
                .navigationTitle("Favoris")
            }
            .tabItem {
                Image(systemName: "heart")
                Text("Favoris")
            }
            
            NavigationStack {
                List(store.watchlistMovies, id: \.id) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        MovieRowView(movie: movie)
                    }
                }
                .navigationTitle("Watchlist")
            }
            .tabItem {
                Image(systemName: "eye")
                Text("Watchlist")
            }
        }
    }
}

#Preview {
    ContentView()
}

