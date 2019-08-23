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
    public var itemSpace: CGFloat = 10
    public var firstItemSpace: CGFloat = 20
    public var lastItemSpace: CGFloat = 20

    public var scrollViewDirection: ScrollViewDirection? = .horizontal
    public var isPagingEnabled: Bool = false

}
