//
//  TMDbAPIEndPoint.swift
//  NetworkLayer
//
// source: https://medium.com/flawless-app-stories/writing-network-layer-in-swift-protocol-oriented-approach-4fa40ef1f908

import Foundation


public enum RESTCountriesAPI {
    case fetchCountries
}

extension RESTCountriesAPI: EndPointType {
    
    /** API base urls. */
    var environmentBaseURL : String {
        switch RESTCountriesAPINetworkManager.environment {
        case .production:
            return "https://api.themoviedb.org/3/"
        default:
            return "https://api.themoviedb.org/3/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    /** API path for specific request. */
    var path: String {
        switch self {
        case .fetchCountries:
            return "rest/v2/all"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    /** generate task based on requested RESTCountries API. */
    var task: HTTPTask {
        switch self {
        //https://restcountries.eu/rest/v2/all
        case .fetchCountries:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}



