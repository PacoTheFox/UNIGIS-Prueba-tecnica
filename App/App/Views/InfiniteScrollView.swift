//
//  InfiniteScrollView.swift
//  App
//
//  Created by Francisco Aguirre San Román on 20/02/24.
//

import Foundation
import SwiftUI
import Kingfisher

extension ContentView {
    
    func formattedReleaseDate(_ dateString: String) -> String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd"

      guard let date = dateFormatter.date(from: dateString) else {
        return dateString
      }

      dateFormatter.dateStyle = .medium
      return dateFormatter.string(from: date)
    }



        
    var popularMoviesList: some View {
        ZStack {
            List {
                ForEach(viewModel.popularMovies) { movie in
                    VStack{
                        ZStack {
                            VStack{
                                HStack {
                                    KFImage(URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)" ))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 70)
                                    
                                    VStack(alignment: .leading) {
                                        Text(movie.title)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding(.bottom, 6)
                                        Text("\(formattedReleaseDate(movie.release_date))")
                                            .font(.subheadline)
                                            .foregroundColor(.colorLine)
                                            .padding(.top, 8)
                                        Text("\(movie.original_language.uppercased())")
                                            .font(.subheadline)
                                            .foregroundColor(.colorLine)
                                        
                                    }


                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    Rectangle() // Add a rectangle with a very small size
                                        .fill(Color.colorBackground) // Set the background color
                                        .frame(width: 30, height: 60) // Set a very small size

                                    CircularProgressView(progress: Double(movie.vote_average) / 10, movie: movie)
                                        .padding(.trailing,10)
                                }
                                .listRowSeparator(.hidden)
                            }
                        }
                        lineSeparator()
                            .padding(.bottom, 10)
                        .listRowSeparator(.hidden)
                        Divider()
                    }
                    .listRowBackground(Color(.colorBackground))
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        self.showWelcomeModal(for: movie)
                    }
                    .onAppear {
                        if viewModel.popularMovies.firstIndex(where: { $0.id == movie.id }) == viewModel.popularMovies.count - 1 && viewModel.popularMovies.count >= 20 {
                            viewModel.fetchNextPage()
                        }
                    }
                    
                }
                
                .listRowSeparator(.hidden)
            }
            
            .listRowSeparator(.hidden)
            .background(Color.gray.opacity(0.2))
            .listStyle(.plain)
            .fullScreenCover(item: $selectedMovie, onDismiss: {
                self.showModal = false
            }) { movie in
                MovieModalView(movie: movie, dismiss: {
                    self.selectedMovie = nil
                    self.showModal = false
                })
            }
            .listRowSeparator(.hidden)
        }
        .padding(.top, -30)

    }
}
