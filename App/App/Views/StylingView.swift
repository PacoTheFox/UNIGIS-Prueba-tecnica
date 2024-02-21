//
//  StylingView.swift
//  App
//
//  Created by Francisco Aguirre San Román on 20/02/24.
//

import Foundation
import SwiftUI
import Kingfisher

extension ContentView {
    var backgroundColor: some View {
        Color("ColorBackground")
            .edgesIgnoringSafeArea(.all)
    }
    
    var title: some View {
        Text("MovieBox")
            .font(.title)
            .padding(EdgeInsets(top: 0 , leading: 4, bottom: 8, trailing: 0))
            .foregroundColor(.yellow)
    }
    
    func line(title: String) -> some View {
        return ZStack(alignment: .bottomLeading) {
            Rectangle()
                .fill(Color("ColorLine"))
                .frame(height: 40)
            
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(.yellow)
                .padding(EdgeInsets(top: 0, leading: 4, bottom: 8, trailing: 0))
        }
    }
    
    func showWelcomeModal(for movie: Movie) {
        // Show the modal with the movie title and poster
        self.selectedMovie = movie
        self.showModal = true
    }
    
    
    func lineSeparator() -> some View {
        return ZStack(alignment: .bottomLeading) {
            Rectangle()
                .fill(Color("ColorLine")) // Set the color of the line
                .frame(height: 4) // Set the line height
                .frame(maxWidth: .infinity)
        }
    }
}
