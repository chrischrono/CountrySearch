//
//  CountrySearchViewController.swift
//  CountrySearch
//
//  Created by Christian on 11/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import UIKit

class CountrySearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var countryTableView: UITableView!
    private let refreshControl = UIRefreshControl()
    @IBOutlet private var statusView: UIView!
    @IBOutlet private var statusViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet private var statusLabel: UILabel!
    @IBOutlet private var currentCountryButton: UIButton!
    @IBOutlet private var loadingView: UIActivityIndicatorView!
    
    private(set) var countrySearchViewModel = CountrySearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initView()
        initViewModel()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let keyword = (searchBar.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        if keyword.count > 0 {
            countrySearchViewModel.keyword = keyword
        }
    }
    @IBAction func currentCountryButtonDidTapped(sender: UIButton) {
        countrySearchViewModel.userRequestCurrentCountryDetail()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}

//MARK:- viewModel related
extension CountrySearchViewController {
    private func initViewModel() {
        countrySearchViewModel.reloadCountryListViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.countryTableView.reloadData()
            }
        }
        countrySearchViewModel.currentCountry.mainAsyncListener = { [weak self] (currentCountry) in
            self?.currentCountryButton.setTitle( String(format: "Current Country: %@", currentCountry ?? ""), for: .normal)
        }
        countrySearchViewModel.isLoading.mainAsyncListener = { [weak self] (isLoading) in
            self?.showLoadingView(isLoading)
        }
        countrySearchViewModel.status.mainAsyncListener = { [weak self] (status) in
            self?.showStatusView(status)
        }
        
        countrySearchViewModel.getCurrentLocation()
    }
}

//MARK:- private func
extension CountrySearchViewController {
    private func initView() {
        initTableView()
    }
    
    private func showStatusView(_ status: String?) {
        guard let status = status else {
            hideStatusView()
            return
        }
        statusLabel.text = status
        statusViewBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        }) { [weak self] (_) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                self?.hideStatusView()
            })
        }
    }
    private func hideStatusView() {
        statusViewBottomConstraint.constant = statusView.bounds.height
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func showLoadingView(_ isLoading: Bool) {
        if isLoading {
            loadingView.startAnimating()
        } else {
            loadingView.stopAnimating()
            refreshControl.endRefreshing()
        }
    }
}

//MARK:- tableView func
extension CountrySearchViewController: UITableViewDataSource {
    private func initTableView() {
        countryTableView.register(UINib(nibName: "CountryViewCell", bundle: nil), forCellReuseIdentifier: "CountryViewCell")
        
        refreshControl.addTarget(self, action:
            #selector(handleReshresh(_:)),
                                 for: UIControl.Event.valueChanged)
        
        refreshControl.tintColor = UIColor.blue
        countryTableView.addSubview(refreshControl)
    }
    
    @objc private func handleReshresh(_ refreshControl: UIRefreshControl?) {
        countrySearchViewModel.fetchCountries()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countrySearchViewModel.getFilteredCountryCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryViewCell", for: indexPath) as! CountryViewCell
        cell.configureCell(model: countrySearchViewModel.getFilteredCountryCellViewModel(at: indexPath.row))
        return cell
    }
    
}
