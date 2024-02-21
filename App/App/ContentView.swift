import SwiftUI
import Kingfisher


struct ContentView: View {
    @StateObject var viewModel: MovieViewModel
    @State var showModal = false
    @State var selectedMovie: Movie?
    @State private var isLoadingNextPage = false

    
    var body: some View {
        VStack{
            ZStack {
                backgroundColor
                VStack(spacing: 0) {
                    title
                    line(title: "Playing now")
                    movieScrollView
                    line(title: "Most Popular")
                }
            }
            HStack{
                popularMoviesList
            }
        }
        .onAppear {
            if viewModel.popularMovies.isEmpty || viewModel.popularMovies.count < 20 {
                viewModel.fetchMostPopularMovies()
            }
        }
        .background(backgroundColor)
    }    
}

