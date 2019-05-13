//
//  CountrySearchVIewModel.swift
//  CountrySearch
//
//  Created by Christian on 12/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import Foundation


class CountrySearchViewModel {
    private var countries = [Country]()
    private(set) var countryCellViewModels = [CountryCellViewModel]()
    private(set) var filteredCountryCellViewModels = [CountryCellViewModel]() {
        didSet {
            reloadCountryListViewClosure?()
        }
    }
    let currentCountry: Dynamic<String?> = Dynamic(nil)
    
    var keyword: String? = nil {
        didSet {
            filterCountries()
        }
    }
    let isLoading = Dynamic(false)
    let status: Dynamic<String?> = Dynamic(nil)
    
    var networkManager: RESTCountriesAPINetworkProtocol = RESTCountriesAPINetworkManager(environment: .production)
    
    var reloadCountryListViewClosure: (()->())?
    
    
}

//MARK:- searchCountry related
extension CountrySearchViewModel {
    func fetchCountries() {
        guard isLoading.value == false else {
            return
        }
        isLoading.value = true
        status.value = "network_loading"
        
        networkManager.fetchCountries { [weak self] (countries, error) in
            guard let self = self else {
                return
            }
            self.isLoading.value = false
            self.status.value = error
            
            guard let countries = countries else {
                return
            }
            
            self.processCountries(countries)
        }
    }
    
    private func processCountries(_ countries: [Country]){
        self.countries = countries
        
        let countryCellViewModels = countries.map { (country) -> CountryCellViewModel in
            return CountryCellViewModel(with: country)
        }
        self.countryCellViewModels = countryCellViewModels
        filterCountries()
    }
    private func filterCountries() {
        if let keyword = keyword?.lowercased(), keyword.count > 0 {
            filteredCountryCellViewModels = countryCellViewModels.filter({ return $0.name.lowercased().range(of: keyword) != nil ||
                $0.capital.lowercased().range(of: keyword) != nil ||
                $0.languages.lowercased().range(of: keyword) != nil
            })
        } else {
            filteredCountryCellViewModels = countryCellViewModels
        }
        
        if filteredCountryCellViewModels.count == 0 {
            status.value = "country_search_no_result"
        }
    }
}

//MARK:- listView related
extension CountrySearchViewModel {
    func getFilteredCountryCount() -> Int {
        return filteredCountryCellViewModels.count
    }
    
    func getFilteredCountryCellViewModel(at index: Int) -> CountryCellViewModel {
        return filteredCountryCellViewModels[index]
    }
}
