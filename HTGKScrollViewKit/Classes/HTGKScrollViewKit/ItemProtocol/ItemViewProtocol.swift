//
//  ItemViewProtocol.swift
//  HeJing
//
//  Created by yujinhai on 2019/5/13.
//  Copyright © 2019 Forever High Tech Ltd. All rights reserved.
//

import UIKit
/// 继承UIView让协议拥有UIView的成员变量
public protocol ItemViewProtocol: UIView {
    
    var currentItem: ItemModelProtocol { get set }
    var action: (ItemModelProtocol)->() { get set }
}
