//
//  CountrySearchVIewModel.swift
//  CountrySearch
//
//  Created by Christian on 12/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import Foundation
import CoreLocation


class CountrySearchViewModel {
    private var currLocation: CLLocation?
    private var currCountryCode: String?
    private var currCountry: Country? {
        didSet{
            currentCountry.value = currCountry?.name
        }
    }
    
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
    var locationManager: LocationManagerProtocol = LocationManager()
    
    var reloadCountryListViewClosure: (()->())?
    var showCountryDetailViewClosure: ((Country)->())?
}

//MARK:- locationManager related
extension CountrySearchViewModel {
    
    func getCurrentLocation() {
        initLocationManager()
        locationManager.requestLocation(placemarkNeeded: true)
    }
    
    private func initLocationManager() {
        guard locationManager.locationUpdateClosure == nil else {
            return
        }
        locationManager.locationUpdateClosure = { [weak self] (location, placemark) in
            self?.updateLocation(location: location, placemark: placemark)
        }
    }
    
    private func updateLocation(location: CLLocation?, placemark: CLPlacemark?) {
        guard let location = location, let placemark = placemark, let countryCode = placemark.isoCountryCode else {
            return
        }
        currLocation = location
        currCountryCode = countryCode
        fetchCountries()
    }
    
}

//MARK:- searchCountry related
extension CountrySearchViewModel {
    
    func userRequestCurrentCountryDetail() {
        guard let country = currCountry else {
            return
        }
        showCountryDetailViewClosure?(country)
    }
    
    func fetchCountries() {
        guard countries.count == 0 else {
            isLoading.value = false
            processCountries(countries)
            return
        }
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
        guard let location = currLocation, let countryCode = currCountryCode else {
            return
        }
        self.countries = countries
        
        let countryCellViewModels = countries.map { (country) -> CountryCellViewModel in
            if country.alpha2Code == countryCode {
                currCountry = country
            }
            let cellViewModel = CountryCellViewModel(with: country)
            if country.latlng.count >= 2 {
                let countryLoc = CLLocation(latitude: country.latlng[0], longitude: country.latlng[1])
                cellViewModel.distance = location.distance(from: countryLoc) / 1000
            } else {
                cellViewModel.distance = .greatestFiniteMagnitude
            }
            return cellViewModel
        }
        self.countryCellViewModels = countryCellViewModels.sorted(by: {return $0.distance < $1.distance })
        filterCountries()
        
        shareCurrentCountry()
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
    private func shareCurrentCountry() {
        guard let country = currCountry else {
            return
        }
        
        if let data = try? JSONEncoder().encode(country) {
            let sharedDefaults = UserDefaults(suiteName: "group.CountrySearchSharing")
            sharedDefaults?.setValue(String(data: data, encoding: .utf8 ), forKey: "currentCountry")
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
