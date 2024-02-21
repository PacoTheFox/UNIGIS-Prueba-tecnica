//
//  MovieScrollView.swift
//  App
//
//  Created by Francisco Aguirre San Román on 20/02/24.
//

import Foundation
import SwiftUI
import Kingfisher

extension ContentView {
    
    var movieScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(viewModel.movies) { movie in
                    KFImage(URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 225)
                }
            }
            .onAppear {
                viewModel.fetchNowPlayingMovies()
            }
            .padding(.leading, 0)
        }
    }
}
