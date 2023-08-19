//
//  MovieListModel.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 19.08.2023.
//

import Foundation

struct MovieListModel: Codable {
  let page: Int
  let results: [Movie]
  let totalPages, totalResults: Int
  
  enum CodingKeys: String, CodingKey {
    case page, results
    case totalPages = "total_pages"
    case totalResults = "total_results"
  }
}

// MARK: - Result
struct Movie: Codable {
  let adult: Bool?
  let backdropPath: String?
  let genreIDS: [Int]?
  let id: Int
  let originalLanguage: String?
  let originalTitle, overview: String?
  let popularity: Double?
  let releaseDate, title: String?
  let video: Bool?
  let voteAverage: Double?
  let voteCount: Int?
  let posterPath: String?
  var posterURL: URL? {
    get {
      return URL(string: "https://image.tmdb.org/t/p/w500" + (posterPath ?? ""))
    }
  }
  var backdropURL: URL? {
    get {
      return URL(string: "https://image.tmdb.org/t/p/w500" + (backdropPath ?? ""))
    }
  }
  
  enum CodingKeys: String, CodingKey {
    case adult
    case backdropPath = "backdrop_path"
    case genreIDS = "genre_ids"
    case id
    case originalLanguage = "original_language"
    case originalTitle = "original_title"
    case overview, popularity
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case title, video
    case voteAverage = "vote_average"
    case voteCount = "vote_count"
  }
}

enum OriginalLanguage: String, Codable {
  case en = "en"
  case ja = "ja"
  case ru = "ru"
  case unknown
  
  init(value: String) {
    if let language = OriginalLanguage(rawValue: value) {
      self = language
    } else {
      self = .unknown
    }
  }
}

