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
//        guard let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey),
//            toView = transitionContext.viewForKey(UITransitionContextToViewKey),
//            fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
//            toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
//            containerView = transitionContext.containerView() else {
//                return
//        }
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey) ?? fromViewController.view
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
        
        let containerView = transitionContext.containerView()
        
        let fromFrame = transitionContext.initialFrameForViewController(fromViewController)
        let toFrame = transitionContext.finalFrameForViewController(toViewController)
        
        let transitionDuration = self.transitionDuration(transitionContext)
        
        let isPresenting = (toViewController.presentingViewController == fromViewController)
        
        let scaleTransform = CGAffineTransformMakeScale(0.95, 0.95)
        
        if isPresenting {
            toView?.frame = CGRectOffset(toFrame, 0, toFrame.size.height)
        } else {
            fromView?.frame = fromFrame
            toView?.frame = toFrame
        }
        
        if isPresenting {
            if let toView = toView {
                containerView?.addSubview(toView)
            }
        } else {
            if let fromView = fromView,
                toView = toView {
                containerView?.insertSubview(toView, belowSubview: fromView)
            }
        }
        
        UIView.animateWithDuration(transitionDuration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: []
            , animations: {
                if isPresenting {
                    fromView?.transform = scaleTransform
                    toView?.frame = toFrame
                } else {
                    fromView?.frame = CGRectOffset(fromFrame, 0, fromFrame.size.height)
                    toViewController.view.transform = CGAffineTransformIdentity
                }
        }) { (finished) in
            let wasCancelled = transitionContext.transitionWasCancelled()
            if wasCancelled {
                toView?.removeFromSuperview()
            }
            
            transitionContext.completeTransition(!wasCancelled)
        }
    }
    
}
