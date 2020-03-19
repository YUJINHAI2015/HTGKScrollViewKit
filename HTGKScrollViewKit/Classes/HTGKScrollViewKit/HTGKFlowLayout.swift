//
//  HTGKFlowLayout.swift
//  HTGKScrollViewKit
//
//  Created by yujinhai on 2020/2/14.
//

import UIKit

public protocol HTGKFlowLayoutDelegate: NSObjectProtocol {
    func waterFlowLayout(flowLayout: HTGKFlowLayout, fixedLength: CGFloat, atIndexPath: IndexPath) -> CGSize
}

public class HTGKFlowLayout: UICollectionViewFlowLayout {
    
    public var columnCount: NSInteger = 1

    public weak var delegate: HTGKFlowLayoutDelegate?
    
    // 每一列的高度
    public var maxYDic: [Int: CGFloat] = [:]
    // 每一列的UICollectionViewLayoutAttributes
    public var attrsArray: [UICollectionViewLayoutAttributes] = []
    
    private lazy var cachedItemSizes = [IndexPath: CGSize]()

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
            if self.scrollDirection == .vertical {
                self.maxYDic[index] = self.sectionInset.top
            }
            else {
                self.maxYDic[index] = self.sectionInset.left
            }
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
            if self.scrollDirection == .vertical {
                return CGSize.init(width: 0, height: (self.maxYDic[maxColumn]! + self.sectionInset.bottom))
            }
            else {
                return CGSize.init(width: (self.maxYDic[maxColumn]! + self.sectionInset.right), height: 0)
            }
        }
    }
    
    // 3、允许每一次重新布局
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    override public func shouldInvalidateLayout(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> Bool {

        return cachedItemSizes[originalAttributes.indexPath] != preferredAttributes.size
    }
       override public func invalidationContext(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutInvalidationContext {
           let context = super.invalidationContext(forPreferredLayoutAttributes: preferredAttributes, withOriginalAttributes: originalAttributes)

           guard let _ = collectionView else { return context }

           let oldContentSize = self.collectionViewContentSize
           cachedItemSizes[originalAttributes.indexPath] = preferredAttributes.size
           let newContentSize = self.collectionViewContentSize
           context.contentSizeAdjustment = CGSize(width: 0, height: newContentSize.height - oldContentSize.height)

           _ = context.invalidateEverything
           return context
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
        
        if self.scrollDirection == .vertical {
            // 每一个item的宽高
            let totalWidth: CGFloat = (self.collectionView?.frame.size.width)!
            let margin: CGFloat = self.minimumLineSpacing * CGFloat(self.columnCount - 1) // 行内间距
            let insert: CGFloat = self.sectionInset.left + self.sectionInset.right // 行外间距
            
            let width: CGFloat = (totalWidth - margin - insert) / CGFloat(self.columnCount) // 每一个item宽度
            let height: CGFloat = (self.delegate?.waterFlowLayout(flowLayout: self, fixedLength: width, atIndexPath: indexPath))!.height
            
            cachedItemSizes[indexPath] = CGSize.init(width: width, height: height)

            //计算每一个item
            let x: CGFloat = self.sectionInset.left + (width + self.minimumLineSpacing) * CGFloat(minColumn)
            var y: CGFloat = 0
            //
            if indexPath.row < self.columnCount {
                y =  self.maxYDic[minColumn]! // 处理第一行
            } else {
                y = self.maxYDic[minColumn]! + self.minimumInteritemSpacing
            }
            self.maxYDic[minColumn] = y + height // 累计高度
            
            //
            let attrs = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
            attrs.frame = CGRect.init(x: x, y: y, width: width, height: height)
            return attrs;

        }
        else {
            // 每一个item的宽高
            let totalHeight: CGFloat = (self.collectionView?.frame.size.height)!
            let margin: CGFloat = self.minimumInteritemSpacing * CGFloat(self.columnCount - 1)
            let insert: CGFloat = self.sectionInset.top + self.sectionInset.bottom
            
            let height: CGFloat = (totalHeight - margin - insert) / CGFloat(self.columnCount)
            let width: CGFloat = (self.delegate?.waterFlowLayout(flowLayout: self, fixedLength: height, atIndexPath: indexPath))!.width
            
            cachedItemSizes[indexPath] = CGSize.init(width: width, height: height)
            //计算每一个item
            let y: CGFloat = self.sectionInset.top + (height + self.minimumInteritemSpacing) * CGFloat(minColumn)
            var x: CGFloat = 0
            //
            if indexPath.row < self.columnCount {
                x =  self.maxYDic[minColumn]! // 处理第一行
            } else {
                x = self.maxYDic[minColumn]! + self.minimumLineSpacing
            }
            self.maxYDic[minColumn] = x + width
            
            //
            let attrs = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
            attrs.frame = CGRect.init(x: x, y: y, width: width, height: height)
            return attrs;

        }
    }
    // 5、布局所有的item
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.attrsArray
    }
}
