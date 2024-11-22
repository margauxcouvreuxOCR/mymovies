import SwiftUI
struct SearchMovieView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            if viewModel.movies.isEmpty {
                Text("No movie found").font(.headline).foregroundColor(.gray)
            } else {
                MovieListView(movies: viewModel.movies)
            }
        }
        .navigationTitle("Search a movie")
        .searchable(text: $viewModel.searchText)
        .onChange(of: viewModel.searchText) { newValue, initial in
            viewModel.fetchMovies(query: newValue)
        }
        
    }
    
    init (movies: [Movie] = []) {
        viewModel = .init(tabMovies: movies)
    }
}
struct MovieListView: View {
    var movies: [Movie]
    
    var body: some View {
        List(movies, id: \.id) { movie in
            NavigationLink(destination: MovieDetailView(movie: movie)) {
                MovieRowView(movie: movie)
            }
        }
        .listStyle(.plain)
    }
}
#Preview {
    NavigationStack {
        SearchMovieView(movies: [Movie.mock, Movie.mock, .mock])
    }
}
extension SearchMovieView {
    
    class ViewModel: ObservableObject {
        
        @Published var searchText = ""
        @Published var movies: [Movie]
        
        init(tabMovies: [Movie]) {
            self.movies = tabMovies
        }
        
        func fetchMovies(query: String) {
            Task {
                let newMovies = await MovieAPI.shared.fetchMovies(query: query)
                DispatchQueue.main.async {
                    self.movies = newMovies
                }
            }
            
        }
    }
}
