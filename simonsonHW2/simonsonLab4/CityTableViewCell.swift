//
//  CityTableViewCell.swift
//  simonsonLab4
//
//  Created by mjsimons on 2/27/20.
//  Copyright © 2020 mjsimons. All rights reserved.
//

import UIKit
class CityTableViewCell: UITableViewCell{
   
    @IBOutlet weak var cityImage: UIImageView!{
        didSet{
            cityImage.layer.cornerRadius = cityImage.bounds.width / 2
            cityImage.clipsToBounds = false
        }
    }
    @IBOutlet weak var cityName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //init code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool){
        super.setSelected(selected, animated: animated)
        //view config
    }
}
