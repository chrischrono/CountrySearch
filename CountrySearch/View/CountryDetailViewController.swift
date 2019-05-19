//
//  CountryDetailViewController.swift
//  CountrySearch
//
//  Created by Christian on 19/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import UIKit

class CountryDetailViewController: UIViewController {
    
    @IBOutlet private weak var flagImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var populationLabel: UILabel!
    @IBOutlet private weak var capitalLabel: UILabel!
    @IBOutlet private weak var regionLabel: UILabel!
    @IBOutlet private weak var regionalBlocsLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var currencyLabel: UILabel!
    
    private(set) var countryDetailViewModel = CountryDetailViewModel()
    
    private static let flagPlaceholder = UIImage(named: "FlagPlaceholder")

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureView()
    }

}

//MARK:- viewModel related
extension CountryDetailViewController {
    private func configureView() {
        flagImageView.kf.setImage(with: URL(string: countryDetailViewModel.flag), placeholder: CountryDetailViewController.flagPlaceholder, options: nil, progressBlock: nil, completionHandler: nil)
        nameLabel.text = countryDetailViewModel.name
        populationLabel.text = "\(countryDetailViewModel.population)"
        capitalLabel.text = countryDetailViewModel.capital
        regionLabel.text = countryDetailViewModel.region
        regionalBlocsLabel.text = countryDetailViewModel.regionalBlocs
        languageLabel.text = countryDetailViewModel.language
        currencyLabel.text = countryDetailViewModel.currency
    }
}
