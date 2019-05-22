//
//  HTGKScrollViewDelegate.swift
//  HeJing
//
//  Created by yujinhai on 2019/5/22.
//  Copyright © 2019 Forever High Tech Ltd. All rights reserved.
//

import UIKit

public protocol HTGKScrollViewDelegate: AnyObject {
    func htgkScrollView(_ scrollView: HTGKScrollView, selectedModel: ItemModelProtocol)
}

public protocol HTGKScrollViewDataSource: AnyObject {
    func htgkScrollView(_ scrollView: HTGKScrollView, viewForRowAt index: Int) -> ItemViewProtocol
}
