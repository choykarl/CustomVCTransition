//
//  PresentFromViewController.swift
//  CustomVCTransition
//
//  Created by karl on 2018/01/29.
//  Copyright © 2018年 Karl. All rights reserved.
//

import UIKit

class PresentViewController: UIViewController,  UIViewControllerTransitioningDelegate {
    
    let animater = BouncePresentAnimation()
    var interactiveTransition: SwipeInteractiveTransition?
    let vc = DismissViewController()
    var isPresent = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        vc.dissmissController = {  [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.vc.dismiss(animated: true, completion: nil)
        }
        
        interactiveTransition = SwipeInteractiveTransition(vc)
        
        let btn = UIButton(frame: CGRect(x: 150, y: 150, width: 100, height: 50))
        btn.backgroundColor = UIColor.purple
        btn.setTitle("点击present", for: .normal)
        self.view.addSubview(btn)
        
        btn.addTarget(self, action: #selector(click), for: .touchUpInside)
    }
    
    @objc func click() {
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animater
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animater
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition
    }
}
