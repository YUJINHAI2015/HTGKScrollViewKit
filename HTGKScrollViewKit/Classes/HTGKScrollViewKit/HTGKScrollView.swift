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
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: HTGKScrollView.HTGKScrollViewCellIdentifier)
        return collectionView
    }()
    
    private var configure: HTGKScrollViewConfigure = HTGKScrollViewConfigure()
    private static let HTGKScrollViewCellIdentifier = "HTGKScrollViewCellIdentifier"

    private lazy var collectionFlowLayout: UICollectionViewFlowLayout! = {

        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = configure.lineSpacing // 行间距
        layout.minimumInteritemSpacing = configure.interitemSpacing // 列间距
        layout.scrollDirection = configure.scrollViewDirection == ScrollViewDirection.vertical ? .vertical : .horizontal
        layout.sectionInset = configure.edgeInsets
        
        if #available(iOS 10.0, *) {
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        } else {
            layout.estimatedItemSize = CGSize.zero
        }
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

    public func reloadIndex(at indexs: [Int]) {
        let indexPaths = indexs.map {
            return IndexPath.init(row: $0, section: 0)
        }
        self.collectionView.reloadItems(at: indexPaths)
    }
    @objc func tapCell(recogniser: UIGestureRecognizer) {
        let view = recogniser.view
        if let tag = view?.tag {
            self.delegate?.htgkScrollView(self, didSelectRowAt: tag)
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HTGKScrollView.HTGKScrollViewCellIdentifier, for: indexPath)
        
        if let view = self.datasource?.htgkScrollView(self, cellForRowAt: indexPath.row) {
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
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 垂直
        if self.configure.scrollViewDirection == .vertical {

            let contentOffsetY = scrollView.contentOffset.y
            let index: Int = Int(contentOffsetY / self.frame.height)
            self.delegate?.htgkScrollView(self, didSelectPageAt: index)
        }
        // 水平
        if self.configure.scrollViewDirection == .horizontal {
            let contentOffsetY = scrollView.contentOffset.x
            let index: Int = Int(contentOffsetY / self.frame.width)
            self.delegate?.htgkScrollView(self, didSelectPageAt: index)
        }
    }
}
extension HTGKScrollView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if let view = self.datasource?.htgkScrollView(self, cellForRowAt: indexPath.row),
        view.frame != CGRect.zero {
            return view.frame.size
        }
        return CGSize.init(width: 0.01, height: 0.01)
    }
}
