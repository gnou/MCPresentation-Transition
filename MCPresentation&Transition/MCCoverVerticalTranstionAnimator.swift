//
//  MCCoverVerticalTranstionAnimator.swift
//  MCPresentation&Transition
//
//  Created by CuiMingyu on 6/13/16.
//  Copyright © 2016 CuiMingyu. All rights reserved.
//

import UIKit

class MCCoverVerticalTranstionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.35
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey),
            toView = transitionContext.viewForKey(UITransitionContextToViewKey),
            fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
            toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            containerView = transitionContext.containerView() else {
                return
        }
        
        let fromFrame = transitionContext.initialFrameForViewController(fromViewController)
        let toFrame = transitionContext.finalFrameForViewController(toViewController)
        
        let transitionDuration = self.transitionDuration(transitionContext)
        
        let isPresenting = (toViewController.presentingViewController == fromViewController)
        
        if isPresenting {
            fromView.frame = fromFrame
            toView.frame = CGRectOffset(toFrame, 0, toFrame.size.height)
        } else {
            fromView.frame = fromFrame
            toView.frame = toFrame
        }
        
        if isPresenting {
            containerView.addSubview(toView)
        } else {
            containerView.insertSubview(toView, belowSubview: fromView)
        }
        
        UIView.animateWithDuration(transitionDuration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: []
            , animations: {
                if isPresenting {
                    toView.frame = toFrame
                } else {
                    fromView.frame = CGRectOffset(fromFrame, 0, fromFrame.size.height)
                }
        }) { (finished) in
            let wasCancelled = transitionContext.transitionWasCancelled()
            if wasCancelled {
                toView.removeFromSuperview()
            }
            
            transitionContext.completeTransition(!wasCancelled)
        }
    }
    
}
