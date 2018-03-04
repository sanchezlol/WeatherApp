//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Alexandr on 3/1/18.
//  Copyright © 2018 Alexandr. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var stripe: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        temperatureLabel.textColor = .white
        descriptionLabel.textColor = .white
        timeLabel.textColor = .white
        
        self.backgroundColor = UIColor(displayP3Red: 22/255, green: 34/255, blue: 44/255, alpha: 1)
        
        stripe.backgroundColor = UIColor(displayP3Red: 51/255, green: 80/255, blue: 102/255, alpha: 1)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }
    func commonInit(temperature : String, description : String, time : String){
        temperatureLabel.text = temperature
        descriptionLabel.text = description
        timeLabel.text = time
        
        icon.image = IconChooser.chooseIcon(forDescription: description)
    }
    
}
