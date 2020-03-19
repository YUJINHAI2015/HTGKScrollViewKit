//
//  ViewController.swift
//  HTGKScrollViewKit
//
//  Created by YUJINHAI2015 on 05/22/2019.
//  Copyright (c) 2019 YUJINHAI2015. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var htgkScrollView: HTGKScrollView = {
        var configure = HTGKScrollViewConfigure()
        configure.lineSpacing = 8
        configure.interitemSpacing = 8
        configure.scrollViewDirection = .vertical
        configure.edgeInsets = UIEdgeInsets.init(top: 12, left: 10, bottom: 12, right: 10)
        configure.scrollViewLayout = .custom
        configure.columnCount = 2

        let scrollView = HTGKScrollView.init(configure)
        scrollView.delegate = self
        scrollView.datasource = self
        scrollView.backgroundColor = .red
        scrollView.customCellIdentifier = "CustomCollectionViewCell"
        return scrollView
    }()

    var imageNames: [String] = ["1","2","3","4","5","6","3","4","5","6","1","2","3","3","4","5","6","1","2","3"]
    var reload: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(htgkScrollView)
        self.htgkScrollView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(0)
            make.top.equalTo(40)
        }
    }
}
extension ViewController: HTGKScrollViewDelegate, HTGKScrollViewDataSource {
    func htgkScrollView(_ scrollView: HTGKScrollView, fixedLength: CGFloat, atIndexPath: IndexPath) -> CGSize {
        
        let image = UIImage.init(named: imageNames[atIndexPath.row])

        let height = (image?.size.height)! * (fixedLength/(image?.size.width)!)
        if self.reload {
            return CGSize.init(width: fixedLength, height: height + 30)
        }

        return CGSize.init(width: fixedLength, height: height)
        
    }
    
    func numberOfRows(_ scrollView: HTGKScrollView) -> Int {
        return imageNames.count
    }
    func htgkScrollView(_ scrollView: HTGKScrollView, cellForRowAt indexPath: IndexPath) -> UIView {
        
        let cell = scrollView.collectionView.dequeueReusableCell(withReuseIdentifier: scrollView.customCellIdentifier, for: indexPath) as! CustomCollectionViewCell
        cell.backgroundColor = .green
        cell.setImageValue(name:imageNames[indexPath.row])
        return cell
    }

    func htgkScrollView(_ scrollView: HTGKScrollView, didSelectPageAt index: Int) {
        print(index)
    }
    
    func htgkScrollView(_ scrollView: HTGKScrollView, didSelectRowAt index: Int) {
        print(index)
        self.reload = true
        self.htgkScrollView.invalidateLayout()
    }
}


