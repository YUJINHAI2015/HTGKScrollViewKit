//
//  HorizontalScrollViewDelegate.swift
//  HeJing
//
//  Created by yujinhai on 2019/5/22.
//  Copyright © 2019 Forever High Tech Ltd. All rights reserved.
//

import UIKit

public protocol HorizontalScrollViewDelegate: AnyObject {
    func horizontalScrollView(_ scrollView: HorizontalScrollView, selectedModel: ItemModelProtocol)
}

public protocol HorizontalScrollViewDataSource: AnyObject {
    func horizontalScrollView(_ scrollView: HorizontalScrollView, viewForRowAt index: Int) -> ItemViewProtocol
}
