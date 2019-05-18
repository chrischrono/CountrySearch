//
//  CountryViewCell.swift
//  CountrySearch
//
//  Created by Christian on 11/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import UIKit
import Kingfisher

class CountryViewCell: UITableViewCell {
    @IBOutlet private var flagImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var populationLabel: UILabel!
    @IBOutlet private var areaLabel: UILabel!
    
    private static let flagPlaceholder = UIImage(named: "FlagPlaceholder")

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(model: CountryCellViewModel) {
        flagImageView.kf.setImage(with: URL(string: model.flag), placeholder: CountryViewCell.flagPlaceholder, options: nil, progressBlock: nil, completionHandler: nil)
        nameLabel.text = model.name
        populationLabel.text = "👤: \(model.population) - \(floor(model.distance))"
        if let area = model.area {
            areaLabel.text = "\(area)"
        } else {
            areaLabel.text = nil
        }
    }
}
