//
//  MCTransitionDelegate.swift
//  MCPresentation&Transition
//
//  Created by CuiMingyu on 6/14/16.
//  Copyright © 2016 CuiMingyu. All rights reserved.
//

import UIKit

class MCTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    let coverVerticalTransitionAnimator = MCCoverVerticalTranstionAnimator()
    let rotateTransitionAnimator = MCRotateTransitionAnimator()

    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return coverVerticalTransitionAnimator
        return rotateTransitionAnimator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return coverVerticalTransitionAnimator
        return rotateTransitionAnimator
    }
}
