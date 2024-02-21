//
//  CircularProgressView.swift
//  App
//
//  Created by Francisco Aguirre San Román on 20/02/24.
//

import Foundation
import SwiftUI
import Kingfisher

extension ContentView {
    
    struct CircularProgressView: View {
        var progress: Double
        var movie: Movie
        
        var color: Color
        
        init(progress: Double, movie: Movie) {
            self.progress = progress
            self.movie = movie
            
            self.color = movie.vote_average < 5.0 ? .yellow : .green
        }
        
        var body: some View {
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 8)
                Circle()
                    .trim(from: 0, to: min(max(progress, 0), 1))
                    .stroke(color, lineWidth: 8)
                    .rotationEffect(.degrees(-90))
                Text("\(Int(movie.vote_average * 10))%")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(8)
            }
            .frame(width: 70, height: 70)
        }
    }
}
