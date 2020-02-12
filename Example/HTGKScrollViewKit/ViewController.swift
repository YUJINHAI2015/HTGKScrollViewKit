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
        configure.edgeInsets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        configure.lineSpacing = 10
    
        configure.scrollViewDirection = .vertical
        let scrollView = HTGKScrollView.init(configure)
        scrollView.delegate = self
        scrollView.datasource = self
        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(htgkScrollView)

        self.htgkScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(200)
            make.leading.trailing.equalTo(0)
            make.height.equalTo(300)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.htgkScrollView.reloadData()
        self.htgkScrollView.reloadIndex(at: [0])
    }
}
extension ViewController: HTGKScrollViewDelegate, HTGKScrollViewDataSource {
    func htgkScrollView(_ scrollView: HTGKScrollView, didSelectRowAt index: Int) {
        print(index)
    }
    
    
    func numberOfRows(_ scrollView: HTGKScrollView) -> Int {
        return 2
    }
    func htgkScrollView(_ scrollView: HTGKScrollView, cellForRowAt index: Int) -> UIView {
        let view = MyView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        view.myText = "self"
        view.backgroundColor = .blue
        return view
    }

}


