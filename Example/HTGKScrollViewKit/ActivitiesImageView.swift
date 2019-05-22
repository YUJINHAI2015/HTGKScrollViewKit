//
//  ActivitiesImageView.swift
//  HeJing
//
//  Created by yujinhai on 2019/5/15.
//  Copyright © 2019 Forever High Tech Ltd. All rights reserved.
//

import UIKit

class ActivitiesImageView: UIView {
        
    private var item: ItemModelProtocol! {
        didSet {
            let data = item as! ServiceItemModel
            self._topImageView.image = data.image
        }
    }
    // MARK: - private var
    lazy private var _topImageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5.0
        return imageView
    }()
    // MARK: - init
    required convenience init(modelProtocol: ItemModelProtocol) {
        self.init()

        defer {
            self.item = modelProtocol
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
        
    }
    private func commonInit() {
                
        self.addSubview(_topImageView)
        
        self._layoutSubviews()
    }
    
    func _layoutSubviews() {
        
        _topImageView.snp.makeConstraints { (make) in

            make.width.equalTo(252)
            make.height.equalTo(108)
            make.edges.equalToSuperview()
        }
    }
}

extension ActivitiesImageView: ItemViewProtocol {
    var action: (ItemModelProtocol) -> () {
        get {
            return { _ in }
        }
        set(newValue) {
//            self.clickBlock = newValue
        }
    }

    
    public var currentItem: ItemModelProtocol {
        get {
            // 不需要获取返回值
            return self.item
        }
        set(newValue) {
            self.item = newValue
        }
    }
}
