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
            Text("Original title / language : \(movie.original_title) (\(movie.original_language))")
            Text("Release date : \(formattedDate(from: movie.release_date))")
            Text("Note: \(String(format: "%.1f", movie.voteAverage)) / 10 (\(movie.vote_count) votes)")

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
                self.image = await self.fetchImage(urlString: movie.poster_path ?? "https://www.animalwebaction.com/media/cache/5e/49/5e49848f06e5cdca18fb0acbbcc79720.png")
            }
        }

        func fetchImage(urlString: String) async -> UIImage? {
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

func formattedDate(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM yyyy" // Format souhaité (ex: "November 2024")
    return formatter.string(from: date)
}
