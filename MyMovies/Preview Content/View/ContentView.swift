import SwiftUI

struct ContentView: View {
    @StateObject var favorites = FavoritesViewModel()

    var body: some View {
        TabView {
            NavigationStack {
                SearchMovieView()
                    .environmentObject(favorites) // Transmettre ici
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Rechercher")
            }

            NavigationStack {
                List(favorites.favoriteMovies, id: \.id) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie).environmentObject(favorites)) {
                        MovieRowView(movie: movie).environmentObject(favorites)
                    }
                }
                .navigationTitle("Favoris")
            }
            .tabItem {
                Image(systemName: "heart")
                Text("Favoris")
            }
        }
    }
}


#Preview {
    ContentView()
        .environmentObject(FavoritesViewModel()) // Ajout de l'EnvironmentObject
}

