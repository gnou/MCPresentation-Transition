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

    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return coverVerticalTransitionAnimator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return coverVerticalTransitionAnimator
    }
}
