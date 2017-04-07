//
//  PhotoAssetsLabTool.swift
//  PhotoPick
//
//  Created by Faz on 2017/4/7.
//  Copyright © 2017年 AW. All rights reserved.
//

import UIKit
import AssetsLibrary

class PhotoAssetsLabTool: NSObject {
    
    private var lib: ALAssetsLibrary!
    
    static let shared: PhotoAssetsLabTool = {
       let tool = PhotoAssetsLabTool()
        tool.lib = ALAssetsLibrary()
        return tool
    }()
    
    ///获取全部相册
    func getAllPhotoGroup(groupClosure: @escaping ([ALAssetsGroup]) -> ()) {
        DispatchQueue.main.async {
            var tempArr = [ALAssetsGroup]()
            self.lib.enumerateGroups(withTypes: ALAssetsGroupType(ALAssetsGroupAll), using: { (group, stop) in
                if group != nil {
                    tempArr.append(group!)
                } else {
                    DispatchQueue.main.async {
                        if tempArr.count > 0 {
                            groupClosure(tempArr)
                        }
                    }
                }
            }, failureBlock: { (error) in
                print(error!)
            })
        }
    }
    
    ///获取单个相册下全部相片
    func getAllPhotoWith(_ group: ALAssetsGroup) -> [ALAsset] {
        var tempArr = [ALAsset]()
        group.enumerateAssets(options: .reverse) { (asset, index, stop) in
            if asset != nil {
                tempArr.append(asset!)
            }
        }
        return tempArr
    }
    
    /// 获取大图
    func getBigPhotoWith(_ asset: ALAsset) -> UIImage {
        let image = UIImage(cgImage: asset.defaultRepresentation().fullScreenImage().takeUnretainedValue(), scale: CGFloat(asset.defaultRepresentation().scale()), orientation: UIImageOrientation(rawValue: asset.defaultRepresentation().orientation().rawValue)!)
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        return UIImage(data: imageData!)!
    }
    
    

}
