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
    
    static let HTGKScrollViewCellIdentifier = "HTGKScrollViewCellIdentifier"
    
    public weak var delegate: HTGKScrollViewDelegate?
    public weak var datasource: HTGKScrollViewDataSource?
    
    public var scrollViewDirection: ScrollViewDirection? = .horizontal
    public var itemSpace: CGFloat = 10
    public var firstItemSpace: CGFloat = 20
    public var lastItemSpace: CGFloat = 20
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: self.bounds,
                                                   collectionViewLayout: self.collectionFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: HTGKScrollView.HTGKScrollViewCellIdentifier)
        return collectionView
    }()
    
    private lazy var collectionFlowLayout: UICollectionViewFlowLayout! = {
        // cell
        let space: CGFloat = 0
        let layout = UICollectionViewFlowLayout()
        //        layout.itemSize = CGSize.init(width: 50, height: 50)
        layout.minimumLineSpacing = itemSpace // 行间距
        layout.minimumInteritemSpacing = itemSpace // 列间距
        layout.scrollDirection = self.scrollViewDirection == ScrollViewDirection.vertical ? .vertical : .horizontal
        layout.sectionInset = UIEdgeInsets.init(top: space, left: firstItemSpace, bottom: space, right: lastItemSpace)
        return layout
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.collectionView)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.addSubview(self.collectionView)
    }
    
    public func reloadData() {
        self.collectionView.reloadData()
    }
    @objc func tapCell(recogniser: UIGestureRecognizer) {
        let view = recogniser.view
        if let tag = view?.tag {
            self.delegate?.htgkScrollView(self, didSelectRowAt: tag)
        }
    }
    
    private func layout(datasource: HTGKScrollViewDataSource) -> CGSize {
        
        var offset: CGFloat = 0
        for index in (0..<datasource.numberOfRows(self)) {
            
            let cell = datasource.htgkScrollView(self, cellForRowAt: index)
            offset += (cell.bounds.size.width) + itemSpace
        }
        let width = firstItemSpace + offset + lastItemSpace
        
        return CGSize.init(width: width, height: self.collectionView.frame.height)
    }
}

extension HTGKScrollView: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datasource?.numberOfRows(self) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HTGKScrollView.HTGKScrollViewCellIdentifier, for: indexPath)
        cell.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        if let view = self.datasource?.htgkScrollView(self, cellForRowAt: indexPath.row) {
            cell.tag = indexPath.row
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapCell(recogniser:)))
            cell.addGestureRecognizer(tap)
            cell.addSubview(view)
        }
        
        return cell
    }
}
extension HTGKScrollView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let view = self.datasource?.htgkScrollView(self, cellForRowAt: indexPath.row) else {
            return CGSize.zero
        }
        return view.frame.size
    }
}
