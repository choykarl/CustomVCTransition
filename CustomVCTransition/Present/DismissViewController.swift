//
//  PresentViewController.swift
//  CustomVCTransition
//
//  Created by karl on 2018/01/26.
//  Copyright © 2018年 Karl. All rights reserved.
//

import UIKit

class DismissViewController: UIViewController {

    var dissmissController: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        btn.backgroundColor = UIColor.blue
        btn.addTarget(self, action: #selector(dismissC), for: .touchUpInside)
        btn.setTitle("点击dismiss", for: .normal)
        self.view.addSubview(btn)
        
        self.view.backgroundColor = UIColor.red
        
        let label = UILabel(frame: CGRect(x: 0, y: 230, width: view.bounds.width, height: 30))
        label.textAlignment = .center
        label.text = "向下滑动dismiss"
        view.addSubview(label)
    }
    
    @objc func dismissC() {
        dissmissController?()
    }
}
