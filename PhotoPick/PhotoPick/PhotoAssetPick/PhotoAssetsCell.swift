//
//  PhotoAssetsCell.swift
//  PhotoPick
//
//  Created by Faz on 2017/4/7.
//  Copyright © 2017年 AW. All rights reserved.
//

import UIKit

class PhotoAssetsCell: UICollectionViewCell {
    
    var selectCallBack = { (isSelected: Bool) -> Void in}
    
    @IBOutlet weak var selectButton: UIButton!
    
    
    @IBOutlet weak var iconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func selectBtnClick(_ sender: UIButton) {
        selectCallBack(!sender.isSelected)
    }
    
    
    class var identifier: String {
        get {
            return "PhotoAssetsCellIdentifier"
        }
    }

}
