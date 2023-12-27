//
//  ApiHandlerViewModel.swift
//  CodingPractice
//
//  Created by Ron Jurincie on 12/26/23.
//

import Foundation

let apiKey = "d606fc3666430d2410d807c11d937d42"

struct Movie: Decodable, Equatable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    
    var posterURL: URL {
        URL(string: "https://image.tmdb.org/t/p/w154/\(posterPath)")!
    }
}

struct MovieResponse: Decodable {
    var results = [Movie]()
}

func loadMovies(page: Int = 1) async throws -> [Movie] {
    do {
        let url = URL(string: "https://themovie.org/3/movie/upcoming?api_key=\(apiKey)/&language=en-us&page=\(page)")!
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try decoder.decode(MovieResponse.self,
                                         from: data)
        return decoded.results
    } catch {
        return []
    }
}


class ApiHandlerViewModel {
    static let shared = ApiHandlerViewModel()
    private var input: String = ""
}

actor Debouncer {
    private let duration: Duration
    private var isPending = false
    
    public init(duration: Duration) {
        self.duration = duration
    }
    
    public func sleep() async -> Bool {
        if isPending { return false }
        isPending = true
        try? await Task.sleep(for: duration)
        isPending = false
        return true
    }
}
