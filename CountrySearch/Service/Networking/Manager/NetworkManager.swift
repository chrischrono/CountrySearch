//
//  NetworkManager.swift
//  NetworkLayer
//
//

import Foundation
import UIKit


protocol RESTCountriesAPINetworkProtocol: class {
    init(environment: NetworkEnvironment)
    
    /**
     Fetch Countries data based on RESTCountries API
     - Parameter completion: block to handle the fetch results
     */
    func fetchCountries(completion: @escaping (_ countries: [Country]?,_ error: String?)->())
    
}

class RESTCountriesAPINetworkManager: RESTCountriesAPINetworkProtocol {
    static var environment : NetworkEnvironment = .production
    let router = Router<RESTCountriesAPI>()
    
    required init(environment: NetworkEnvironment) {
        RESTCountriesAPINetworkManager.environment = environment
    }
    
    /**
     Fetch Countries data based on RESTCountries API
     - Parameter completion: block to handle the fetch results
     */
    func fetchCountries(completion: @escaping (_ countries: [Country]?,_ error: String?)->()) {
        router.request(.fetchCountries) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            do {
                /*let jsonData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                 print(jsonData)*/
                let countries = try JSONDecoder().decode([Country].self, from: data)
                completion(countries, nil)
            }catch {
                print(error)
                completion(nil, NetworkResponse.unableToDecode.rawValue)
            }
        }
    }
    
}
