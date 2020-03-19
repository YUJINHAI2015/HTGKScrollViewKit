//
//  CustomCollectionViewCell.swift
//  HTGKScrollViewKit_Example
//
//  Created by yujinhai on 2020/3/19.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit

class CustomCollectionViewCell: UICollectionViewCell {

    let imageView: UIImageView = {
        let img = UIImageView.init()
        return img
    }()

    func setImageValue(name: String) {
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.imageView.image = UIImage.init(named: name)
    }
    override func layoutSubviews() {
    }
}
