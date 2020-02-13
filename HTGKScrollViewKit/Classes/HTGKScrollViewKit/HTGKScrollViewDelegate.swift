//
//  HTGKScrollViewDelegate.swift
//  HeJing
//
//  Created by yujinhai on 2019/5/22.
//  Copyright © 2019 Forever High Tech Ltd. All rights reserved.
//

import UIKit

public protocol HTGKScrollViewDelegate: AnyObject {
    func htgkScrollView(_ scrollView: HTGKScrollView, didSelectRowAt index: Int)
    func htgkScrollView(_ scrollView: HTGKScrollView, didSelectPageAt index: Int)

}

public protocol HTGKScrollViewDataSource: AnyObject {
    
    func numberOfRows(_ scrollView: HTGKScrollView) -> Int
    func htgkScrollView(_ scrollView: HTGKScrollView, cellForRowAt index: Int) -> UIView
    

}
