CountriesSearch
=============

This repository contains a sample app for requesting RESTCountries API and show the Country where the user is located.


---
# Installation

To install the dependencies
* Open a terminal and cd to the directory containing the Podfile
* Run the `pod install` command

(For further details regarding cocoapod installation see https://cocoapods.org/)


---
# Existing Functionalities

The app is currently able to load Countries from RESTCountries API, and sort them based on the distance from user's current location, and show them in list form or detailed (for the Current Country).

* When the app loads, it will try to get user current location, then load the Countries from RESTCountries API, and show them in the tableView
* You can also filter the Countries, by filling the "Search keyword" field. The filter logics are a simple keyword finding inside Country's Name, Capital and Language. 
* Upon selecting Current Country, it will open a view with detailed data of the Current Country

---
# Development Steps

1. Create new project based on single view app
2. Create folders for MVVM pattern
3. Add CountrySearchViewController and Design the UI layout to show Countries List
4. Add Networking Layer to handle the RESTCountries API
5. Add Models and ViewModel, that will show the Countries List at CountrySearchViewController
6. Add pods: Kingfisher
7. Add CountryDetailViewController and Design the UI layout to show the Current Country's detail
8. Add CountryDetailViewModel to prepare the Country's detailed data
9. Add Today Extension Widget for Current Country 
10. Add Unit Tests to test the process


