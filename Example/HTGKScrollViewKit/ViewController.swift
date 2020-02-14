//
//  ViewController.swift
//  HTGKScrollViewKit
//
//  Created by YUJINHAI2015 on 05/22/2019.
//  Copyright (c) 2019 YUJINHAI2015. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var htgkScrollView: HTGKScrollView = {
        
        var configure = HTGKScrollViewConfigure()
        configure.lineSpacing = 50
        configure.interitemSpacing = 10
        configure.edgeInsets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        configure.scrollViewDirection = .horizontal
        configure.columnCount = 3
        configure.scrollViewLayout = .custom
        let scrollView = HTGKScrollView.init(configure)
//        scrollView.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 200)
        scrollView.delegate = self
        scrollView.datasource = self
        scrollView.collectionView.isScrollEnabled = true
        scrollView.backgroundColor = .red
        return scrollView
    }()

    var imageNames: [String] = ["1","2","3","4","5","6","3","4","5","6","1","2","3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(htgkScrollView)
        self.htgkScrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
////        self.htgkScrollView.reloadData()
//        self.htgkScrollView.reloadIndex(at: [0])
//    }
}
extension ViewController: HTGKScrollViewDelegate, HTGKScrollViewDataSource {
    func htgkScrollView(flowLayout: HTGKFlowLayout, updateHeightForWidth: CGFloat, atIndexPath: IndexPath) -> CGFloat {
        let image = UIImage.init(named: imageNames[atIndexPath.row])
        let ScreenWidth = UIScreen.main.bounds.size.width
        let width = (ScreenWidth - 30)/2
        let height = (image?.size.height)! * (width/(image?.size.width)!)
        return height
    }
    
    
    func numberOfRows(_ scrollView: HTGKScrollView) -> Int {
        return imageNames.count
    }
    func htgkScrollView(_ scrollView: HTGKScrollView, cellForRowAt index: Int) -> UIView {
        
        let view: MyView = MyView()
        
        view.updateValue(name: imageNames[index], index: "\(index)")

        view.backgroundColor = .blue
        return view
    }

    func htgkScrollView(_ scrollView: HTGKScrollView, didSelectPageAt index: Int) {
        print(index)
    }
}


