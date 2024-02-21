import Foundation
import SwiftUI
import Kingfisher

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var popularMovies: [Movie] = []
    private let movieFetcher: MovieFetcher
    @Published var currentPage: Int = 1
    @State var moviesPerPage: Int = 0
    @Published var genres: [Genre] = []
    
    var moviesWithGenres: [MovieWithGenres] {
        movies.map { movie in
            let genres = self.genres.filter { genre in
                movie.genre_ids.contains(genre.id)
            }
            return MovieWithGenres(movie: movie, genres: genres)
        }
    }
    
    init(movieFetcher: MovieFetcher = MovieFetcher()) {
        self.movieFetcher = movieFetcher
        fetchGenres()
    }
    
    
    
    func fetchNowPlayingMovies() {
        movieFetcher.fetchNowPlayingMovies { fetchedMovies in
            DispatchQueue.main.async {
                self.movies = fetchedMovies
            }
        }
    }
    
    func fetchMostPopularMovies() {
        movieFetcher.fetchMovies(page: currentPage) { fetchedMovies in
            DispatchQueue.main.async {
                self.popularMovies += fetchedMovies
                self.currentPage += 1
            }
        }
    }
    
    
    func fetchNextPage() {
        let lastMovie = popularMovies.last
        
        movieFetcher.fetchMovies(page: currentPage) { fetchedMovies in
            DispatchQueue.main.async {
                let uniqueMovies = fetchedMovies.filter { movie in
                    !self.popularMovies.contains(where: { $0.id == movie.id })
                }
                self.popularMovies.append(contentsOf: uniqueMovies)
                
                if let lastMovie = lastMovie, let currentMovie = self.popularMovies.last, lastMovie.id == currentMovie.id {
                    self.currentPage += 1
                    print("Page \(self.currentPage) fetched with \(uniqueMovies.count) movies")
                    self.fetchNextPage() // Fetch the next page recursively
                }
                
                if uniqueMovies.isEmpty {
                    print("End Reached")
                }
            }
        }
    }

    
    func eliminateDuplicates() {
        var movieSet = Set<Int>()
        var movieDict = [Int: Movie]()
        popularMovies = popularMovies.filter { movie in
            if movieDict.updateValue(movie, forKey: movie.id) == nil {
                movieSet.insert(movie.id)
                return true
            } else {
                return false
            }
        }
    }
    

}

class MovieFetcher {
    func fetchNowPlayingMovies(completion: @escaping ([Movie]) -> Void) {
        let url = URL(string: "\(Constants.baseUrl)/movie/now_playing?api_key=\(Constants.apiKey)")!
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(TMDBResponse.self, from: data)
                    completion(response.results)
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
    
    func fetchMovies(page: Int, completion: @escaping ([Movie]) -> Void) {
        let url = URL(string: "\(Constants.baseUrl)/movie/popular?api_key=\(Constants.apiKey)&language=en-US&page=\(page)")!
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(TMDBResponse.self, from: data)
                    completion(response.results)
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
        
}



