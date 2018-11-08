//  CityTableViewCell.swift
//  AdamskaPrognozaPogody
//
//  Created by iza on 02/11/2018.
//  Copyright © 2018 ITIK. All rights reserved.
//
import UIKit

class CityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
