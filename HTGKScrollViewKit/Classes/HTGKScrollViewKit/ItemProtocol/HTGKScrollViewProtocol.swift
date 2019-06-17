//
//  IHTGKScrollViewProtocol.swift
//  HeJing
//
//  Created by yujinhai on 2019/5/13.
//  Copyright © 2019 Forever High Tech Ltd. All rights reserved.
//

import UIKit
/// 继承UIView让协议拥有UIView的成员变量
public protocol HTGKScrollViewProtocol: UIView {
    
    var currentItem: HTGKScrollViewModelProtocol { get set }
    var action: (HTGKScrollViewModelProtocol)->() { get set }
}
