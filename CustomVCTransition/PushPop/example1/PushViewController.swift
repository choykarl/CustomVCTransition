//
//  PushViewController.swift
//  CustomVCTransition
//
//  Created by karl on 2018/01/29.
//  Copyright © 2018年 Karl. All rights reserved.
//

import UIKit

class PushViewController: UIViewController {
    
    let imageView = UIImageView(frame: CGRect(x: 100, y: 100, width: 107, height: 125))
    private let popVc = PopViewController()
    private var transitioning: PushPopInteractiveTransitioning!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "PushVc"
        imageView.image = UIImage(named: "墨莲")
        imageView.contentMode = .scaleAspectFill
        self.view.addSubview(imageView)
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushVc)))
    }
    
    @objc func pushVc() {
        transitioning = PushPopInteractiveTransitioning(popVc)
        self.navigationController?.delegate = self
        self.navigationController?.pushViewController(popVc, animated: true)
    }
    
    var tempPoint = CGPoint.zero
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let point = touches.first?.location(in: imageView) {
            tempPoint = point
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let point = touches.first?.location(in: view) {
            imageView.frame = CGRect(origin: CGPoint(x: point.x - tempPoint.x,y:  point.y - tempPoint.y), size: imageView.bounds.size)
        }
    }
    
}

// MARK: - UINavigationControllerDelegate
extension PushViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if toVC.isKind(of: ViewController.self) {
            return nil
        }
        return PushPopAnimatedTransitioning<PushViewController, PopViewController>(operation)
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        // 是手势触发,并且是pop
        if transitioning.isGestureTransitioning && (animationController as? PushPopAnimatedTransitioning<PushViewController, PopViewController>)?.operation == .pop {
            return transitioning
        }
        return nil
    }
}

// MARK: - PushPopAnimatedTransitioningable
extension PushViewController: PushPopAnimatedTransitioningable {
    
    func getInitialFrame() -> CGRect {
        return imageView.frame
    }
    
    func getFinalFrame() -> CGRect {
        return view.frame
    }
}
