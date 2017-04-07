//
//  PhotoAssetsViewController.swift
//  PhotoPick
//
//  Created by Faz on 2017/4/7.
//  Copyright © 2017年 AW. All rights reserved.
//

import UIKit
import AssetsLibrary

class PhotoAssetsViewController: UICollectionViewController {
    
    var assetArr: [ALAsset]
    var selectedArr: [ALAsset]
    
    var imgAssetCallBack = {(selectedSetArr: [ALAsset]) -> Void in}

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView!.showsVerticalScrollIndicator = false
        collectionView!.backgroundColor = UIColor.white
        collectionView!.register(UINib(nibName: "PhotoAssetsCell", bundle: nil), forCellWithReuseIdentifier: PhotoAssetsCell.identifier)
        
        let rightItem = UIBarButtonItem(title: "确定", style: UIBarButtonItemStyle.done, target: self, action: #selector(PhotoAssetsViewController.confirmClick))
        navigationItem.rightBarButtonItem = rightItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    init(with group: ALAssetsGroup!, selectedArr: [ALAsset]!) {
        self.assetArr = PhotoAssetsLabTool.shared.getAllPhotoWith(group)
        self.selectedArr = selectedArr
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
        navigationItem.title = group.value(forProperty: ALAssetsGroupPropertyName) as! String?
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func confirmClick() {
        imgAssetCallBack(selectedArr)
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assetArr.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoAssetsCell.identifier, for: indexPath) as! PhotoAssetsCell
        let item = assetArr[indexPath.row]
        cell.iconImageView.image = UIImage(cgImage: item.thumbnail().takeUnretainedValue())
        cell.selectCallBack = {(isSelected: Bool) in
            if isSelected {
                if self.selectedArr.count >= 9 {
                    return
                }
                cell.selectButton.isSelected = isSelected
                self.selectedArr.append(item)
                self.navigationItem.title = "\(self.selectedArr.count)/9"
            } else {
                let arr = self.selectedArr
                let index = arr.index(of: item)
                cell.selectButton.isSelected = isSelected
                self.selectedArr.remove(at: index!)
                self.navigationItem.title = "\(self.selectedArr.count)/9"
            }
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let _ = PhotoAssetsLabTool.shared.getBigPhotoWith(assetArr[indexPath.row])
        
    }

    
    
    

}

extension PhotoAssetsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width
        return CGSize(width: (width - 3 * 5) / 4, height: (width - 3 * 5) / 4)
    }
}
