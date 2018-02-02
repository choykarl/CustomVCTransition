//
//  PopViewController.swift
//  CustomVCTransition
//
//  Created by karl on 2018/01/29.
//  Copyright © 2018年 Karl. All rights reserved.
//

import UIKit

class PopViewController: UIViewController, PushPopAnimatedTransitioningable {
    func getInitialFrame() -> CGRect {
        return view.frame
    }
    
    func getFinalFrame() -> CGRect {
        return imageView.frame
    }
    
    let imageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PopVc"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(0)
        }
    }
}
