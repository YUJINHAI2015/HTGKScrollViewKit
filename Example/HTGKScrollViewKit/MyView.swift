//
//  MyView.swift
//  HTGKScrollViewKit_Example
//
//  Created by yujinhai on 2019/7/6.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit

extension UIView {
    
    static func loadNib(name: String) -> UIView {
        
        guard let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? UIView
            else {
            return UIView()
        }
        
        return view
    }
}

class MyView: UIView {

    var topImageView: UIImageView = UIImageView()
    var bottomLabel: UILabel = UILabel()

    var block: (()->())?
    
    func updateValue(name: String, index: String) {

        self.addSubview(topImageView)
        self.addSubview(bottomLabel)

        topImageView.image = UIImage.init(named: name)
        bottomLabel.text = index
        
        let ScreenWidth = UIScreen.main.bounds.size.width
        let width = (ScreenWidth - 30)/2
        let height = (self.topImageView.image?.size.height)! * (width/(self.topImageView.image?.size.width)!)
        
        self.topImageView.snp.makeConstraints { (make) in
            make.leading.top.right.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
        
        self.bottomLabel.snp.makeConstraints { (make) in
            make.leading.bottom.right.equalToSuperview()
            make.top.equalTo(topImageView.snp.bottom)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.block?()
        }
    }
}
