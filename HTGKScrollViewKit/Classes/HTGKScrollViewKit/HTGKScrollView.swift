//
//  HTGKScrollView.swift
//  HeJing
//
//  Created by yujinhai on 2019/5/9.
//  Copyright © 2019 Forever High Tech Ltd. All rights reserved.
//

import UIKit
import SnapKit

public class HTGKScrollView: UIView {
    
    public weak var delegate: HTGKScrollViewDelegate?
    public weak var datasource: HTGKScrollViewDataSource?
    
    public lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect.zero,
                                                   collectionViewLayout: self.collectionFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = false
        collectionView.isDirectionalLockEnabled = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: HTGKScrollView.HTGKScrollViewCellIdentifier)
        return collectionView
    }()
    
    private var configure: HTGKScrollViewConfigure = HTGKScrollViewConfigure()
    private static let HTGKScrollViewCellIdentifier = "HTGKScrollViewCellIdentifier"

    public var customCellIdentifier = HTGKScrollView.HTGKScrollViewCellIdentifier {
        didSet {
            let moduleName = Bundle.main.infoDictionary!["CFBundleName"] as! String
            let personClass: AnyClass? = NSClassFromString(moduleName + "." + customCellIdentifier)
            
            collectionView.register(personClass.self, forCellWithReuseIdentifier: customCellIdentifier)
        }
    }

    private lazy var collectionFlowLayout: UICollectionViewFlowLayout! = {

        let layout = HTGKFlowLayout()
        layout.minimumLineSpacing = configure.lineSpacing // 行间距
        layout.minimumInteritemSpacing = configure.interitemSpacing // 列间距
        layout.scrollDirection = configure.scrollViewDirection == .vertical ? .vertical : .horizontal
        layout.sectionInset = configure.edgeInsets
        layout.columnCount = configure.columnCount
        layout.delegate = self
        return layout
    }()
    
    
    // func
    public init(_ configure: HTGKScrollViewConfigure? = nil) {
        super.init(frame: .zero)
        self.configure = configure ?? HTGKScrollViewConfigure()
        self.addSubview(self.collectionView)
        self.initUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func reloadData() {
        self.collectionView.reloadData()
    }
    public func invalidateLayout() {
        self.collectionFlowLayout.invalidateLayout()
    }
    public func reloadIndex(at indexs: [Int]) {
        let indexPaths = indexs.map {
            return IndexPath.init(row: $0, section: 0)
        }
        self.collectionView.reloadItems(at: indexPaths)
    }
    @objc func tapCell(recogniser: UIGestureRecognizer) {
        let view = recogniser.view
        if let tag = view?.tag {
            
            if let _ = self.delegate?.responds(to: #selector(self.delegate?.htgkScrollView(_:didSelectRowAt:))) {
                self.delegate?.htgkScrollView?(self, didSelectRowAt: tag)
            }
        }
    }
    private func initUI() {
        self.collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension HTGKScrollView: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datasource?.numberOfRows(self) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if self.customCellIdentifier == HTGKScrollView.HTGKScrollViewCellIdentifier {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HTGKScrollView.HTGKScrollViewCellIdentifier, for: indexPath)
            
            if let view = self.datasource?.htgkScrollView(self, cellForRowAt: indexPath) {
                cell.tag = indexPath.row
                let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapCell(recogniser:)))
                cell.addGestureRecognizer(tap)
                            
                cell.subviews.forEach { (view) in
                    view.removeFromSuperview()
                }
                cell.addSubview(view)
                if view.frame == CGRect.zero {
                    view.snp.makeConstraints { (make) in
                        make.edges.equalToSuperview()
                    }
                }
            }
            return cell
        }
        else {
            let cell = self.datasource?.htgkScrollView(self, cellForRowAt: indexPath)
            return cell as! UICollectionViewCell
        }
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if let _ = self.delegate?.responds(to: #selector(self.delegate?.htgkScrollView(_:didSelectRowAt:))) {
            self.delegate?.htgkScrollView?(self, didSelectRowAt: indexPath.item)
        }

    }
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 垂直
        var currentIndex: Int = 0
        if self.configure.scrollViewDirection == .vertical {

            let contentOffsetY = scrollView.contentOffset.y
            currentIndex = Int(contentOffsetY / self.frame.height)
        }
        // 水平
        if self.configure.scrollViewDirection == .horizontal {
            let contentOffsetY = scrollView.contentOffset.x
            currentIndex = Int(contentOffsetY / self.frame.width)
        }
        
        if let _ = self.delegate?.responds(to: #selector(self.delegate?.htgkScrollView(_:didSelectRowAt:))) {
            self.delegate?.htgkScrollView?(self, didSelectPageAt: currentIndex)
        }

    }
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.delegate?.htgkScrollView?(self, didScrollAtScrollView: scrollView)
    }
}

extension HTGKScrollView: HTGKFlowLayoutDelegate {
    public func waterFlowLayout(flowLayout: HTGKFlowLayout, fixedLength: CGFloat, atIndexPath: IndexPath) -> CGSize
    {
        
        if configure.scrollViewLayout == .custom {
            
            return ((self.delegate?.htgkScrollView(self, fixedLength: fixedLength, atIndexPath: atIndexPath))!)
        } else {
            return CGSize.zero
        }
    }
}
