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
        let scrollView = HTGKScrollView.init(frame: CGRect.init(x: 0, y: 100, width: self.view.frame.size.width, height: 200))
        scrollView.delegate = self
        scrollView.datasource = self
        scrollView.firstItemSpace = 0
//        scrollView.scrollViewDirection = .vertical
        scrollView.backgroundColor = .green
        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.addSubview(htgkScrollView)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.htgkScrollView.reloadData()
    }
}
extension ViewController: HTGKScrollViewDelegate, HTGKScrollViewDataSource {
    func htgkScrollView(_ scrollView: HTGKScrollView, didSelectRowAt index: Int) {
        print(index)
    }
    
    
    func numberOfRows(_ scrollView: HTGKScrollView) -> Int {
        return 5
    }
    func htgkScrollView(_ scrollView: HTGKScrollView, cellForRowAt index: Int) -> HTGKScrollViewCell {
        let view = MyView.init(frame: CGRect.init(x: 0, y: 0, width: 90, height: 50))
        view.backgroundColor = .red
        return view
    }

}


