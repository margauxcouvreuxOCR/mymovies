import Foundation
class MovieAPI {
    
    static let shared = MovieAPI()

    func fetchMovies(query: String) async -> [Movie] {
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?query=\(query)&include_adult=false&language=en-US&page=1\(movieDbApiKey)") else {
            print("Invalid URL")
            return []
        }
        print(url.absoluteString)
        do {
            let (data,_) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let movieData = try decoder.decode(MoviesResponse.self, from: data) // Décoder en tableau
            return movieData.results
        } catch {
            print(error.localizedDescription)
            return[]
        }
    }
    
}




