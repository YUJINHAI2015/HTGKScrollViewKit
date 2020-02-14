//
//  HTGKScrollViewDelegate.swift
//  HeJing
//
//  Created by yujinhai on 2019/5/22.
//  Copyright © 2019 Forever High Tech Ltd. All rights reserved.
//

import UIKit

@objc public protocol HTGKScrollViewDelegate: NSObjectProtocol {
    @objc optional func htgkScrollView(_ scrollView: HTGKScrollView, didSelectRowAt index: Int)
    @objc optional func htgkScrollView(_ scrollView: HTGKScrollView, didSelectPageAt index: Int)
    @objc optional func htgkScrollViewDidScroll(_ scrollView: HTGKScrollView, atScrollView: UIScrollView)
    @objc optional func htgkScrollView(flowLayout: HTGKFlowLayout, updateHeightForWidth: CGFloat, atIndexPath: IndexPath) -> CGFloat

}

public protocol HTGKScrollViewDataSource: NSObjectProtocol {
    
    func numberOfRows(_ scrollView: HTGKScrollView) -> Int
    func htgkScrollView(_ scrollView: HTGKScrollView, cellForRowAt index: Int) -> UIView
    

}
