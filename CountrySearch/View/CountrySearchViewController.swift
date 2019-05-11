//
//  CountrySearchViewController.swift
//  CountrySearch
//
//  Created by Christian on 11/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import UIKit

class CountrySearchViewController: UIViewController {
    
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var countryTableView: UITableView!
    @IBOutlet private var statusView: UIView!
    @IBOutlet private var statusLabel: UILabel!
    @IBOutlet private var currentCountryButton: UIButton!
    @IBOutlet private var loadingView: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

