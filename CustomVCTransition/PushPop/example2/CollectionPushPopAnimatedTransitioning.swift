//
//  CollectionPushPopAnimatedTransitioning.swift
//  CustomVCTransition
//
//  Created by karl on 2018/02/02.
//  Copyright © 2018年 Karl. All rights reserved.
//

import UIKit

class CollectionPushPopAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    private(set) var operation = UINavigationControllerOperation.none
    
    private lazy var tempView: UIImageView = {
        let tempView = UIImageView()
        tempView.contentMode = .scaleAspectFit
        tempView.layer.masksToBounds = true
        return tempView
    }()
    
    init(_ operation: UINavigationControllerOperation) {
        super.init()
        self.operation = operation
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
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
    
    private func doPushAnimation(_ transitionContext: UIViewControllerContextTransitioning){
        guard let fromVC = transitionContext.viewController(forKey: .from) as? CollectionViewController else {
            return
        }
        guard let toVC = transitionContext.viewController(forKey: .to) as? CollectionViewPopController else {
            return
        }
        
        let initialFrame = fromVC.initialFrame
        tempView.frame = initialFrame
        tempView.image = fromVC.image
        
        transitionContext.containerView.addSubview(toVC.view)
        transitionContext.containerView.addSubview(tempView)
        toVC.view.frame = initialFrame
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            self.tempView.frame = transitionContext.finalFrame(for: toVC)
            toVC.view.frame = transitionContext.finalFrame(for: toVC)
            fromVC.collectionView.alpha = 0
        }) { (_) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            toVC.imageView.image = self.tempView.image
            self.tempView.removeFromSuperview()
        }
    }
    
    
    private func doPopAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? CollectionViewPopController else {
            return
        }
        guard let toVC = transitionContext.viewController(forKey: .to) as? CollectionViewController else {
            return
        }
        
        let finalFrame = toVC.initialFrame
        
        tempView.frame = transitionContext.initialFrame(for: fromVC)
        tempView.image = toVC.image
        
        transitionContext.containerView.addSubview(toVC.view)
        transitionContext.containerView.addSubview(tempView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            self.tempView.frame = finalFrame
            toVC.collectionView.alpha = 1
            fromVC.imageView.frame = finalFrame
        }) { (_) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            toVC.clickCell?.isHidden = false
            self.tempView.removeFromSuperview()
        }
    }
}
