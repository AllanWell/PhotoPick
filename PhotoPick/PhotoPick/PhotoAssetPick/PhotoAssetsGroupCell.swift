//
//  PhotoAssetsGroupCell.swift
//  PhotoPick
//
//  Created by Faz on 2017/4/7.
//  Copyright © 2017年 AW. All rights reserved.
//

import UIKit

class PhotoAssetsGroupCell: UITableViewCell {
    
    
    @IBOutlet weak var iconImageView: UIImageView!
    
   
    @IBOutlet weak var titleLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    class var identifier: String {
        get{
            return "PhotoAssetsGroupCellIdentifier"
        }
    }
    
    
}
