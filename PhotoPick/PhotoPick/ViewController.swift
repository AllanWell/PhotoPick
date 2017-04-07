//
//  ViewController.swift
//  PhotoPick
//
//  Created by Faz on 2017/4/7.
//  Copyright © 2017年 AW. All rights reserved.
//

import UIKit
import AssetsLibrary

class ViewController: UIViewController {
    
    fileprivate var selectedArr = [ALAsset]()
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView!.register(UINib(nibName: "PhotoAssetsCell", bundle: nil), forCellWithReuseIdentifier: PhotoAssetsCell.identifier)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func choseBtnClick(_ sender: UIButton) {
        PhotoAssetsLabTool.shared.getAllPhotoGroup { (assetsGroup) in
            let groupVC = PhotoAssetsGroupViewController(with: assetsGroup)
            groupVC.selecteCallBack = {[unowned self] selectedGroup in
                self.selectedArr = selectedGroup
                self.collectionView.reloadData()
            }
            let nav = UINavigationController(rootViewController: groupVC)
            self.present(nav, animated: true, completion: nil)
        }
    }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoAssetsCell.identifier, for: indexPath) as! PhotoAssetsCell
        let item = selectedArr[indexPath.row]
        cell.selectButton.isHidden = true
        cell.iconImageView.image = UIImage(cgImage: item.thumbnail().takeUnretainedValue())
        return cell
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
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
