//
//  BouncePresentAnimation.swift
//  CustomVCTransition
//
//  Created by karl on 2018/01/26.
//  Copyright © 2018年 Karl. All rights reserved.
//

import UIKit

class BouncePresentAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        var isDismiss = false
        
        guard let toVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
            return
        }
        
        guard let fromVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {
            return
        }
        
        isDismiss = fromVc.isKind(of: DismissViewController.self)
        
        let ScreenBounds = UIScreen.main.bounds
        let duration = transitionDuration(using: transitionContext)
        
        if isDismiss {
            transitionContext.containerView.addSubview(toVc.view)
            transitionContext.containerView.sendSubview(toBack: toVc.view)
            UIView.animate(withDuration: duration, animations: {
                fromVc.view.frame = ScreenBounds.offsetBy(dx: 0, dy: ScreenBounds.height)
            }, completion: { (flag) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        } else {
            let finalFrame = transitionContext.finalFrame(for: toVc)
            transitionContext.containerView.addSubview(toVc.view)
            toVc.view.frame = finalFrame.offsetBy(dx: 0, dy: ScreenBounds.height)
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                toVc.view.frame = finalFrame
            }) { (flag) in
                transitionContext.completeTransition(flag)
            }
        }
    }
}
