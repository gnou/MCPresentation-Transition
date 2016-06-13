//
//  MCCoverVerticalTranstionAnimator.swift
//  MCPresentation&Transition
//
//  Created by CuiMingyu on 6/13/16.
//  Copyright © 2016 CuiMingyu. All rights reserved.
//

import UIKit

class MCCoverVerticalTranstionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting = false
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey),
            toView = transitionContext.viewForKey(UITransitionContextToViewKey),
            fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
            toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            containerView = transitionContext.containerView() else {
                return
        }
    }
    
//    func animationEnded(transitionCompleted: Bool) {
//    }
}
