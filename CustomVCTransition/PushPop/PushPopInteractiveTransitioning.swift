//
//  PushPopInteractiveTransitioning.swift
//  CustomVCTransition
//
//  Created by karl on 2018/02/01.
//  Copyright © 2018年 Karl. All rights reserved.
//

import UIKit

class PushPopInteractiveTransitioning: UIPercentDrivenInteractiveTransition {
    
    var isGestureTransitioning = false // 是否是手势触发的pop
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
            isGestureTransitioning = true
            self.controller?.navigationController?.popViewController(animated: true)
        case .changed:
            var changeX = gesture.translation(in: gesture.view).x
            
            if changeX < 0 {
                changeX = 0
            }
            scale = changeX / UIScreen.main.bounds.width
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
    
    override func cancel() {
        super.cancel()
        isGestureTransitioning = false
    }
}
