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
    
    var configure: HTGKScrollViewConfigure = HTGKScrollViewConfigure()
    
    public weak var delegate: HTGKScrollViewDelegate?
    public weak var datasource: HTGKScrollViewDataSource?
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: self.bounds,
                                                   collectionViewLayout: self.collectionFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = configure.isPagingEnabled
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: HTGKScrollView.HTGKScrollViewCellIdentifier)
        return collectionView
    }()
    
    private static let HTGKScrollViewCellIdentifier = "HTGKScrollViewCellIdentifier"

    private lazy var collectionFlowLayout: UICollectionViewFlowLayout! = {
        // cell
        let space: CGFloat = 0
        let layout = UICollectionViewFlowLayout()
        //        layout.itemSize = CGSize.init(width: 50, height: 50)
        layout.minimumLineSpacing = configure.itemSpace // 行间距
        layout.minimumInteritemSpacing = configure.itemSpace // 列间距
        layout.scrollDirection = configure.scrollViewDirection == ScrollViewDirection.vertical ? .vertical : .horizontal
        layout.sectionInset = UIEdgeInsets.init(top: space, left: configure.firstItemSpace, bottom: space, right: configure.lastItemSpace)
        return layout
    }()
    public func reloadData() {
        self.collectionView.reloadData()
    }

    public convenience init(frame: CGRect, configure: HTGKScrollViewConfigure? = nil) {
        self.init(frame: frame)
        self.configure = configure ?? HTGKScrollViewConfigure()
        self.addSubview(self.collectionView)
    }
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addSubview(self.collectionView)
    }
    
    @objc func tapCell(recogniser: UIGestureRecognizer) {
        let view = recogniser.view
        if let tag = view?.tag {
            self.delegate?.htgkScrollView(self, didSelectRowAt: tag)
        }
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
