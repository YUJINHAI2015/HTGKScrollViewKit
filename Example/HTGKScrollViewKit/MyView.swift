//
//  MyView.swift
//  HTGKScrollViewKit_Example
//
//  Created by yujinhai on 2019/7/6.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit

class MyView: UIView {

    var myText: String = "" {
        didSet {
            self.myTextLabel.text = myText
            self.addSubview(myTextLabel)
            self.myTextLabel.snp.makeConstraints { (make) in
//                make.width.equalTo(200)
//                make.height.equalTo(200)
//                make.top.leading.equalTo(0)
                make.edges.equalToSuperview()
            }
        }
    }
    
    var myTextLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
}
