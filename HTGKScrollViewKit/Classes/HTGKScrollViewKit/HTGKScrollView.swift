//
//  HTGKScrollView.swift
//  HeJing
//
//  Created by yujinhai on 2019/5/9.
//  Copyright © 2019 Forever High Tech Ltd. All rights reserved.
//

import UIKit
import SnapKit

public enum ScrollViewDirection: Int {
    case vertical // 垂直
    case horizontal // 水平
}

public class HTGKScrollView: UIView {

    public weak var delegate: HTGKScrollViewDelegate?
    public weak var datasource: HTGKScrollViewDataSource? {
        didSet {
            // 初始化
            self.commonInit(items: items)
        }
    }
    public var items: [ItemModelProtocol]!
    public var scrollViewDirection: ScrollViewDirection? = .horizontal

    private let itemSpace: CGFloat = 10
    
    private lazy var _scrollView: UIScrollView = {
        let scrollView = UIScrollView.init()
        return scrollView
    }()

    ///   布局Scrollview上面的view
    ///
    /// - Parameters:
    ///   - items: 继承ItemModelProtocol的数据模型
    public convenience init(items: [ItemModelProtocol], direction: ScrollViewDirection?) {
        
        self.init()
        self.items = items
        self.scrollViewDirection = direction
    }
    public convenience init(items: [ItemModelProtocol]) {
        
        self.init()
        self.items = items
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private func commonInit(items: [ItemModelProtocol]) {
        /*
         |sapce-items-space|
         */
        self.addSubview(_scrollView)

        // itemView
        var previousView: UIView? = nil
        
        for (index, model) in items.enumerated() {

            let itemViews = self.datasource!.htgkScrollView(self, viewForRowAt: index)
            
            _scrollView.addSubview(itemViews)
            itemViews.currentItem = model
            itemViews.action = { [weak self](item) in
                self!.delegate?.htgkScrollView(self!, selectedModel: item)
            }
            
            itemViews.snp.makeConstraints { (make) in
                if self.scrollViewDirection == .horizontal {
                    make.top.equalToSuperview()
                    make.bottom.equalToSuperview()
                    make.leading.equalTo(previousView?.snp.trailing ?? itemSpace).offset(itemSpace)
                } else {
                    
                    make.leading.equalTo(_scrollView.snp.leading)
                    make.top.equalTo(previousView?.snp.bottom ?? _scrollView.snp.top).offset(itemSpace)
                }
        
            }
            // 每次存储最后一个view
            previousView = itemViews
        }
        // scrollView以最后一个view的约束为准
        _scrollView.snp.makeConstraints { (make) in
            if self.scrollViewDirection == .horizontal {
                make.top.equalTo(previousView!.snp.top)
                make.trailing.equalTo(previousView!.snp.trailing).offset(itemSpace)
            } else {
                make.bottom.equalTo(previousView!.snp.bottom).offset(itemSpace)
                make.trailing.equalTo(previousView!.snp.trailing).offset(itemSpace)
            }
            make.edges.equalToSuperview()
        }
    }
}
