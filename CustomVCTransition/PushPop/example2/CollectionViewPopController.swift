//
//  CollectionViewPopController.swift
//  CustomVCTransition
//
//  Created by karl on 2018/02/02.
//  Copyright © 2018年 Karl. All rights reserved.
//

import UIKit

class CollectionViewPopController: UIViewController {

    let imageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "POP"
        imageView.frame = view.bounds
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        view.backgroundColor = UIColor.white
    }
    
    deinit {
        print("CollectionViewPopController  \(#function)")
    }
}
