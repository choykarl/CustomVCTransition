//
//  PushPopAnimatedTransitioning.swift
//  CustomVCTransition
//
//  Created by karl on 2018/01/29.
//  Copyright © 2018年 Karl. All rights reserved.
//

import UIKit
protocol PushPopAnimatedTransitioningable where Self: UIViewController {
    func getInitialFrame() -> CGRect
    func getFinalFrame() -> CGRect
    var imageView: UIImageView { get }
    
}

class PushPopAnimatedTransitioning<PUSH, POP>: NSObject, UIViewControllerAnimatedTransitioning where PUSH: PushPopAnimatedTransitioningable, POP: PushPopAnimatedTransitioningable {
    private lazy var tempView: UIImageView = {
        let tempView = UIImageView()
        tempView.contentMode = .scaleAspectFit
        tempView.layer.masksToBounds = true
        return tempView
    }()
    private(set) var operation = UINavigationControllerOperation.none
    
    init(_ operation: UINavigationControllerOperation) {
        super.init()
        self.operation = operation
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        doTransitionAnimation(operation, transitionContext: transitionContext)
    }
    
    private func doTransitionAnimation(_ operation: UINavigationControllerOperation, transitionContext: UIViewControllerContextTransitioning) {
        if operation == .push {
            doPushAnimation(transitionContext)
        } else if operation == .pop {
            doPopAnimation(transitionContext)
        }
    }
    
    private func doPushAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVc = transitionContext.viewController(forKey: .from) as? PUSH else { return }
        guard let toVc = transitionContext.viewController(forKey: .to) as? POP else { return }
        
        let finalFrame = transitionContext.finalFrame(for: toVc)
        let containView = transitionContext.containerView
        
        tempView.frame = fromVc.getInitialFrame()
        tempView.image = fromVc.imageView.image
        
        containView.addSubview(toVc.view)
        containView.addSubview(tempView)
        
        toVc.imageView.image = fromVc.imageView.image
        toVc.imageView.alpha = 0
        toVc.view.frame = fromVc.imageView.frame
        
        fromVc.imageView.alpha = 0
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            self.tempView.frame = finalFrame
            toVc.view.frame = finalFrame
        }) { (flag) in
            toVc.imageView.alpha = 1
            fromVc.imageView.alpha = 1
            self.tempView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    private func doPopAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVc = transitionContext.viewController(forKey: .from) as? POP else { return }
        guard let toVc = transitionContext.viewController(forKey: .to) as? PUSH else { return }
        
        let containView = transitionContext.containerView
        
        tempView.frame = fromVc.getInitialFrame()
        tempView.image = fromVc.imageView.image
        containView.addSubview(toVc.view)
        containView.addSubview(tempView)
        
        toVc.imageView.alpha = 0
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            self.tempView.frame = toVc.getInitialFrame()
        }) { (flag) in
            toVc.imageView.alpha = 1
            self.tempView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
