//
//  MovieRowView.swift
//  MyMovies
//
//  Created by Margaux Mazaleyras on 22/11/2024.
//

import SwiftUI

struct MovieRowView: View {
    var movie: Movie
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: movie.poster_path ?? "https://www.animalwebaction.com/media/cache/5e/49/5e49848f06e5cdca18fb0acbbcc79720.png")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width:50, height:50)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } placeholder: {
                ProgressView()
                    .frame(width: 50, height: 50)
            }
            
            Text(movie.title)
                .font(.headline)
        }
        .padding() // Ajoute un padding horizontal (espacement sur les côtés)
        .frame(maxWidth: .infinity) // Prendre toute la largeur de l'écran
        .background(Color.white)  // Ajouter une couleur de fond pour le cadre
        .clipShape(RoundedRectangle(cornerRadius: 10))  // Appliquer des coins arrondis sur l'ensemble de la cellule
        .shadow(radius: 3)  // Optionnel : ajouter une ombre pour plus d'effet visuel
        .padding(.horizontal)
        
    }
}

#Preview() {
    MovieRowView(movie: Movie.mock)
}
