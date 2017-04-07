//
//  PhotoAssetsGroupViewController.swift
//  PhotoPick
//
//  Created by Faz on 2017/4/7.
//  Copyright © 2017年 AW. All rights reserved.
//

import UIKit
import AssetsLibrary

class PhotoAssetsGroupViewController: UITableViewController {
    
    var selecteCallBack = {(selectArr: [ALAsset]) -> Void in}
    
    private var groupArr: [ALAssetsGroup]
    private var selectedArr: [ALAsset]

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "照片"
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.rowHeight = 50
        
        tableView.register(UINib(nibName: "PhotoAssetsGroupCell", bundle: nil), forCellReuseIdentifier: PhotoAssetsGroupCell.identifier)
        
        let righgBar = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.plain, target: self, action: #selector(PhotoAssetsGroupViewController.dismissClick))
        navigationItem.rightBarButtonItem = righgBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    init(with group: [ALAssetsGroup]) {
        self.groupArr = group
        self.selectedArr = [ALAsset]()
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - method
    
    @objc private func dismissClick() {
        navigationController?.dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupArr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoAssetsGroupCell.identifier) as! PhotoAssetsGroupCell
        let item = groupArr[indexPath.row]
        cell.iconImageView.image = UIImage(cgImage: item.posterImage().takeUnretainedValue())
        cell.titleLabel.text = String(format: "%@(%ld)", item.value(forProperty: ALAssetsGroupPropertyName) as! CVarArg, item.numberOfAssets())
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PhotoAssetsViewController(with: groupArr[indexPath.row], selectedArr: selectedArr)
        vc.imgAssetCallBack = self.selecteCallBack
        navigationController?.pushViewController(vc, animated: true)
    }

}
