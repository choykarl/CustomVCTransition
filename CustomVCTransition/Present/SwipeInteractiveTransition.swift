//
//  SwipeInteractiveTransition.swift
//  CustomVCTransition
//
//  Created by karl on 2018/01/26.
//  Copyright © 2018年 Karl. All rights reserved.
//

import UIKit

class SwipeInteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    private weak var controller: UIViewController?
    private var beginPoint = CGPoint.zero
    private var scale: CGFloat = 0
    init(_ controller: UIViewController) {
        super.init()
        self.controller = controller
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizer(_:)))
        
        controller.view.addGestureRecognizer(pan)
    }
    
    @objc func panGestureRecognizer(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            self.controller?.dismiss(animated: true, completion: nil)
        case .changed:
            var changeY = gesture.translation(in: gesture.view).y
            
            if changeY < 0 {
                changeY = 0
            }
            scale = changeY / UIScreen.main.bounds.height
            if scale > 1 {
                scale = 1
            }
            update(scale)
        case .cancelled:
            cancel()
            beginPoint = .zero
            scale = 0
        case .ended:
            if scale >= 0.5 {
                finish()
            } else {
                cancel()
            }
            scale = 0
            beginPoint = .zero
        default:
            break
        }
    }
}
