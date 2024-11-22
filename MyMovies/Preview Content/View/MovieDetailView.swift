import SwiftUI
import UIKit
struct MovieDetailView: View {
    
    var movie : Movie
    @ObservedObject var viewModel: ViewModel
    
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
        }
        .padding()
    }
}
#Preview {
    MovieDetailView(movie: Movie.mock)
}
extension MovieDetailView {
    
    class ViewModel: ObservableObject {
        
        var movie: Movie
        
        @Published var image: UIImage?
        
        init(movie: Movie) {
            self.movie = movie
            Task {
//                let urlString = MovieAPI.shared.getImageUrl(urlImage: movie.posterPath)
                self.image = await self.fetchImage(movie.posterURL)
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
