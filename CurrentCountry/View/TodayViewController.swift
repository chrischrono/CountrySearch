//
//  TodayViewController.swift
//  CurrentCountry
//
//  Created by Christian on 19/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import UIKit
import NotificationCenter
import Kingfisher

class TodayViewController: UIViewController, NCWidgetProviding {
    
    
    @IBOutlet private weak var flagImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var populationLabel: UILabel!
    @IBOutlet private weak var capitalLabel: UILabel!
    @IBOutlet private weak var regionLabel: UILabel!
    @IBOutlet private weak var fieldStackView: UIStackView!
    @IBOutlet private weak var regionalBlocsLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var currencyLabel: UILabel!
    
    private(set) var todayViewModel = TodayViewModel()
    
    private static let flagPlaceholder = UIImage(named: "FlagPlaceholder")
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.)
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        
        initViewModel()
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        if todayViewModel.updateCountry() {
            completionHandler(.newData)
        } else {
            completionHandler(.noData)
        }
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .compact {
            self.preferredContentSize = maxSize
        } else if activeDisplayMode == .expanded {
            let rect = fieldStackView.frame
            self.preferredContentSize = CGSize(width: maxSize.width, height: rect.origin.y + rect.size.height + 20)
        }
    }
    
}

//MARK:- private func
extension TodayViewController {
    
    private func initViewModel() {
        todayViewModel.configureViewClosure = configureView
    }
    private func configureView() {
        
        flagImageView.kf.setImage(with: URL(string: todayViewModel.flag), placeholder: TodayViewController.flagPlaceholder, options: nil, progressBlock: nil, completionHandler: nil)
        nameLabel.text = todayViewModel.name
        populationLabel.text = "👤: \(todayViewModel.population)"
        capitalLabel.text = todayViewModel.capital
        regionLabel.text = todayViewModel.region
        regionalBlocsLabel.text = todayViewModel.regionalBlocs
        languageLabel.text = todayViewModel.language
        currencyLabel.text = todayViewModel.currency
    }
}
