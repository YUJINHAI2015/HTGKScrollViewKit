//
//  ViewController.swift
//  HTGKScrollViewKit
//
//  Created by YUJINHAI2015 on 05/22/2019.
//  Copyright (c) 2019 YUJINHAI2015. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let sc = self.scrollView()
        self.view.addSubview(sc)
        
//        sc.snp.makeConstraints { (make) in
//            make.height.equalTo(250)
//            make.width.equalTo(414)
//            make.top.equalTo(self.view.snp.top).offset(100)
//            make.leading.equalToSuperview()
//        }

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func scrollView() -> UIView {
        let item2 = ServiceItemModel.init(id: 2,image: UIImage.init(named: "Rectangle Copy")!, title: "sfasdfawea")
        let items = [item2,item2,item2,item2,item2,item2,item2]
        
        // scrollview
        let scrollview = HTGKScrollView.init()
        scrollview.backgroundColor = .red
        scrollview.frame = CGRect.init(x: 0, y: 100, width: 414, height: 200)
        scrollview.items = items
        scrollview.delegate = self
        scrollview.datasource = self
        return scrollview
    }
    
    
    
}
extension ViewController: HTGKScrollViewDelegate, HTGKScrollViewDataSource {
    func htgkScrollView(_ scrollView: HTGKScrollView, selectedModel: ItemModelProtocol) {
        print(selectedModel)
        
    }
    
    func htgkScrollView(_ scrollView: HTGKScrollView, viewForRowAt index: Int) -> ItemViewProtocol {
        
        return ActivitiesImageView(frame: CGRect.init(x: 0, y: 0, width: 252, height: 120)) as ItemViewProtocol
    }
    
}


