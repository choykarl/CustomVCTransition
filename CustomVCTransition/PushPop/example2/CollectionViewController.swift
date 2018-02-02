//
//  CollectionViewController.swift
//  CustomVCTransition
//
//  Created by karl on 2018/02/02.
//  Copyright © 2018年 Karl. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    
    var initialFrame = CGRect.zero
    var image: UIImage?
    private let images = ["1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg", "6.jpg"]
    private(set) var collectionView: UICollectionView!
    private(set) weak var clickCell: CollectionViewCell?
    private var transitioning: PushPopInteractiveTransitioning!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PUSH"
        
        let layout = UICollectionViewFlowLayout()
        let size = (view.bounds.width - 3 * 10) / 2
        layout.itemSize = CGSize(width: size, height: size)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(collectionView)
    }

    deinit {
        print("CollectionViewController  \(#function)")
    }
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.imageView.image = UIImage(named: images[indexPath.row % images.count])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        clickCell = cell
        initialFrame = cell.superview!.convert(cell.frame, to: view)
        image = cell.imageView.image
        cell.isHidden = true
        let vc = CollectionViewPopController()
        transitioning = PushPopInteractiveTransitioning(vc)
        self.navigationController?.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension CollectionViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if toVC.isKind(of: ViewController.self) {
            return nil
        }
        return CollectionPushPopAnimatedTransitioning(operation)
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        // 是手势触发,并且是pop
        if transitioning.isGestureTransitioning && (animationController as? CollectionPushPopAnimatedTransitioning)?.operation == .pop {
            return transitioning
        }
        return nil
    }
}


class CollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.frame = bounds
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        addSubview(imageView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
