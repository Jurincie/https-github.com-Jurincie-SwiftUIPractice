//
//  MovieApiHandlerView.swift
//  CodingPractice
//
//  Created by Ron Jurincie on 12/26/23.
//

import SwiftUI

struct MovieApiHandlerView: View {
    @State private var movies = [Movie]()
    @State private var currentPage = 1
    
    var body: some View {
        List(movies) { movie in
            VStack(alignment: .leading, spacing: 10) {
                Text(movie.title)
                    .font(.headline)
                Text(movie.overview)
                    .lineLimit(3)
                    .font(.subheadline)
            }
            .task {
                if movie == movies.last {
                    do {
                        movies += try await loadMovies()
                    } catch {
                        print(ApiError.badUrlError)
                    }
                }
            }
        }
        .task {
            do {
                movies = try await loadMovies()
            } catch {
                print(ApiError.badUrlError)
            }
        }
        .refreshable {
            do {
                movies = try await loadMovies()
            } catch {
                print(ApiError.badUrlError)
            }
        }
    }
}

#Preview {
    MovieApiHandlerView()
}
