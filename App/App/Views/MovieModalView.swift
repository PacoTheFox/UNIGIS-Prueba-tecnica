//
//  MovieModalView.swift
//  App
//
//  Created by Javier Aguirre San Román on 20/02/24.
//

import Foundation
import SwiftUI
import Kingfisher

extension ContentView {
    
    struct MovieModalView: View {
        let movie: Movie
        let dismiss: () -> Void
        
        
        func formattedReleaseDate(_ dateString: String) -> String {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy-MM-dd"

          guard let date = dateFormatter.date(from: dateString) else {
            return dateString
          }

          dateFormatter.dateStyle = .medium
          return dateFormatter.string(from: date)
        }

        
        var body: some View {
            VStack(alignment: .center) {
                Button(action: {
                    self.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }.padding(.leading)
                    .padding(.top, 30)
                KFImage(URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 250)
                    .overlay(
                        Rectangle()
                            .stroke(Color.colorLine, lineWidth: 3)
                    )
                //    .padding(.leading, 110)
                VStack() {
                    Text(movie.title)
                        .font(.largeTitle)
                    //              .padding(.leading, 90)
                        .foregroundColor(.white)
                    
                    Text("\(formattedReleaseDate(movie.release_date))")
                        .font(.subheadline)
                    //             .padding(.leading,90)
                        .foregroundColor(.colorLine)
                }
                Spacer()
                VStack(alignment: .leading){
                Text("Overview")
                    .font(.footnote)
                    .padding(.leading)
                    .foregroundColor(.white)
                    .bold()
                Text(movie.overview)
                    .font(.footnote)
                    .padding(.leading)
                    .foregroundColor(.colorLine)
            }
                Spacer()
                    .padding()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.9))
            .edgesIgnoringSafeArea(.all)
            .presentationBackground(.clear)
        }
        
        
        
    }
}
