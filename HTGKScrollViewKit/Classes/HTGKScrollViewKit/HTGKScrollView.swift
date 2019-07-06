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
    public weak var datasource: HTGKScrollViewDataSource?
    
    public var scrollViewDirection: ScrollViewDirection? = .horizontal
    public var itemSpace: CGFloat = 10
    public var firstItemSpace: CGFloat = 20
    public var lastItemSpace: CGFloat = 20

    private lazy var _scrollView: UIScrollView = {
        let scrollView = UIScrollView.init(frame: self.bounds)
        scrollView.backgroundColor = .blue
        return scrollView
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(_scrollView)

    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.addSubview(_scrollView)
    }

    override public func didMoveToWindow() {
        super.didMoveToWindow()
        self.draw()
    }
    public func reloadData() {
        self.draw()
    }
    @objc func tapCell(recogniser: UIGestureRecognizer) {
        let view = recogniser.view
        if let tag = view?.tag {
            self.delegate?.htgkScrollView(self, didSelectRowAt: tag)
        }
    }
    private func draw() {
        // 移除原来的
        for view in _scrollView.subviews {
            view.removeFromSuperview()
        }
        
        guard let datasource = self.datasource else {
            return
        }
        self.layout(datasource: datasource)
    }
    
    private func layout(datasource: HTGKScrollViewDataSource) {
        
        var offset: CGFloat = firstItemSpace
        for index in (0..<datasource.numberOfRows(self)) {
            
            let cell = datasource.htgkScrollView(self, cellForRowAt: index)
            cell.tag = index
            _scrollView.addSubview(cell)
            
            let geture = UITapGestureRecognizer.init(target: self, action: #selector(tapCell(recogniser:)))
            cell.addGestureRecognizer(geture)

            if self.scrollViewDirection == .horizontal {
                
                cell.frame.origin = CGPoint.init(x: offset, y: 0)
                offset += (cell.bounds.size.width) + itemSpace
            } else {
                cell.frame.origin = CGPoint.init(x: 0, y: offset)
                offset += (cell.bounds.size.height) + itemSpace
            }
        }
        
        var size = _scrollView.bounds.size
        
        if self.scrollViewDirection == .horizontal {
            size.width = offset - itemSpace + lastItemSpace
        } else {
            size.height = offset - itemSpace + lastItemSpace
        }
        _scrollView.contentSize = size
    }
}
