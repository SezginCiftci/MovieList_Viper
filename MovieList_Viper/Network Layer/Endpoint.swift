//
//  Endpoint.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 19.08.2023.
//

import Foundation

protocol EndpointProtocol {
    var baseURL: String {get}
    var path: String {get}
    var method: HTTPMethod {get}
    var header: [String: String]? {get}
    var parameters: [String: Any]? {get}
    func request() -> URLRequest
}

extension EndpointProtocol {
    var header: [String: String]? {
        return nil
    }
    var parameters: [String: Any]? {
        return nil
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum Endpoint {
    case getTrending(pageIndex: Int)
    case getPopular(pageIndex: Int)
    case getUpcoming(pageIndex: Int)
    case getSimilar(movieId: Int)
    case getRecommendations(movieId: Int)
    case getDetail(movieId: Int)
}

extension Endpoint: EndpointProtocol {
    
    var baseURL: String {
        return APIConstants.baseUrl
    }
    
    var apiKey: String {
        return APIConstants.apiKey
    }
    
    var path: String {
        switch self {
        case .getTrending:                     return "/3/trending/movie/day"
        case .getPopular:                      return "/3/movie/popular"
        case .getUpcoming:                     return "/3/movie/upcoming"
        case .getSimilar(let movieId):         return "/3/movie/\(movieId)/similar"
        case .getRecommendations(let movieId): return "/3/movie/\(movieId)/recommendations"
        case .getDetail(let movieId):          return "/3/movie/\(movieId)"
        }
    }
    
    //Can be modified in the future
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: [String : Any]? {
        var parameters: [String: String] = [ParameterKey.apiKey.rawValue: apiKey,
                                            ParameterKey.language.rawValue: "en-US"]
        
        switch self {
        case .getTrending(let pageIndex), .getPopular(let pageIndex), .getUpcoming(let pageIndex):
            parameters[ParameterKey.pageIndex.rawValue] = "\(pageIndex)"
            return parameters
        case .getSimilar, .getRecommendations:
            parameters[ParameterKey.pageIndex.rawValue] = "1"
            return parameters
        default:
            return parameters
        }
    }
    
    
    func request() -> URLRequest {
        guard var components = URLComponents(string: baseURL) else {
            fatalError("*_* Base Url Error")
        }
        components.path = path
        
        components.queryItems = parameters?.compactMap { key, value in
            URLQueryItem(name: key, value: value as? String)
        }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        
        return request
    }
    
    enum ParameterKey: String {
        case language = "language"
        case apiKey = "api_key"
        case pageIndex = "page"
    }
}
