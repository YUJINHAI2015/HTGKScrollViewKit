//
//  HTGKScrollViewConfigure.swift
//  HTGKScrollViewKit
//
//  Created by yujinhai on 2019/8/23.
//

import UIKit

public enum ScrollViewDirection: Int {
    case vertical // 垂直
    case horizontal // 水平
}
public struct HTGKScrollViewConfigure {
    public init() {
        
    }
    
    // 外边距
    public var edgeInsets: UIEdgeInsets = UIEdgeInsets.zero
    // 行间距
    public var lineSpacing: CGFloat = 0
    // 列间距
    public var interitemSpacing: CGFloat = 0
    // 滚动方向
    public var scrollViewDirection: ScrollViewDirection? = .horizontal
}
