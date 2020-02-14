//
//  HTGKFlowLayout.swift
//  HTGKScrollViewKit
//
//  Created by yujinhai on 2020/2/14.
//

import UIKit

public protocol HTGKFlowLayoutDelegate: NSObjectProtocol {
    func waterFlowLayout(flowLayout: HTGKFlowLayout, updateHeightForWidth: CGFloat, atIndexPath: IndexPath) -> CGFloat
}

public class HTGKFlowLayout: UICollectionViewFlowLayout {
    
    public var columnCount: NSInteger = 1

    public weak var delegate: HTGKFlowLayoutDelegate?
    
    // 每一列的高度
    public var maxYDic: [Int: CGFloat] = [:]
    // 每一列的UICollectionViewLayoutAttributes
    public var attrsArray: [UICollectionViewLayoutAttributes] = []
    
    override init() {
        super.init()
        
        self.columnCount = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // 1、准备工作
    override public func prepare() {
        // 计算Y值
        for (index, _) in (0 ..< self.columnCount).enumerated() {
            self.maxYDic[index] = self.sectionInset.top
        }
        
        //
        self.attrsArray.removeAll()
        
        if let row: Int = self.collectionView?.numberOfItems(inSection: 0) {
            
            for (index, _) in (0 ..< row).enumerated() {
                
                if let attrs = self.layoutAttributesForItem(at: IndexPath.init(row: index, section: 0)) {
                    
                    self.attrsArray.append(attrs)
                }
            }
        }
    }
    
    // 2、contentSize
    override public var collectionViewContentSize: CGSize {
        get {
            // 找出最长的一列
            var maxColumn = 0
            
            self.maxYDic.forEach { (key, value) in
                if value > self.maxYDic[maxColumn]! {
                    maxColumn = key
                }
                
            }
            return CGSize.init(width: 0, height: (self.maxYDic[maxColumn]! + self.sectionInset.bottom))
        }
    }
    
    // 3、允许每一次重新布局
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    // 4、布局每一个属性
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        // 找出最短的一列
        var minColumn = 0
        self.maxYDic.forEach { (key, value) in
            if value < self.maxYDic[minColumn]! {
                minColumn = key
            }
        }
        
        // 每一个item的宽高
        let totalWidth: CGFloat = (self.collectionView?.frame.size.width)!
        let margin: CGFloat = self.minimumLineSpacing * CGFloat(self.columnCount - 1)
        let insert: CGFloat = self.sectionInset.left + self.sectionInset.right
        
        let width: CGFloat = (totalWidth - margin - insert) / CGFloat(self.columnCount)
        let height: CGFloat = (self.delegate?.waterFlowLayout(flowLayout: self, updateHeightForWidth: width, atIndexPath: indexPath))!
        
        //计算每一个item
        let x: CGFloat = self.sectionInset.left + (width + self.minimumLineSpacing) * CGFloat(minColumn)
        let y: CGFloat = self.maxYDic[minColumn]! + self.minimumInteritemSpacing
        //
        self.maxYDic[minColumn] = y + height
        
        //
        let attrs = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
        attrs.frame = CGRect.init(x: x, y: y, width: width, height: height)
        return attrs;
    }
    // 5、布局所有的item
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.attrsArray
    }
}
