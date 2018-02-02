//
//  ViewController.swift
//  CustomVCTransition
//
//  Created by karl on 2018/01/26.
//  Copyright © 2018年 Karl. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

        let btn = UIButton(frame: CGRect(x: 150, y: 150, width: 100, height: 50))
        btn.setTitle("presentVC", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 2
        self.view.addSubview(btn)
        btn.addTarget(self, action: #selector(toPresentVc), for: .touchUpInside)
        
        
        let btn1 = UIButton(frame: CGRect(x: 150, y: 230, width: 100, height: 50))
        btn1.setTitle("toPushVC1", for: .normal)
        btn1.setTitleColor(UIColor.black, for: .normal)
        btn1.layer.borderColor = UIColor.black.cgColor
        btn1.layer.borderWidth = 2
        self.view.addSubview(btn1)
        btn1.addTarget(self, action: #selector(toPushVC1), for: .touchUpInside)
        
        let btn2 = UIButton(frame: CGRect(x: 150, y: 310, width: 100, height: 50))
        btn2.setTitle("toPushVC2", for: .normal)
        btn2.setTitleColor(UIColor.black, for: .normal)
        btn2.layer.borderColor = UIColor.black.cgColor
        btn2.layer.borderWidth = 2
        self.view.addSubview(btn2)
        btn2.addTarget(self, action: #selector(toPushVC2), for: .touchUpInside)
    }
    
    @objc func toPresentVc() {
        let presentController = PresentViewController()
        self.navigationController?.pushViewController(presentController, animated: true)
    }
    
    @objc func toPushVC1() {
        let pushController = PushViewController()
        self.navigationController?.pushViewController(pushController, animated: true)
    }
    
    @objc func toPushVC2() {
        let pushController = CollectionViewController()
        self.navigationController?.pushViewController(pushController, animated: true)
    }
}

