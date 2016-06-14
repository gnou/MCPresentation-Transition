//
//  MCRotateTransitionAnimator.swift
//  MCPresentation&Transition
//
//  Created by CuiMingyu on 6/14/16.
//  Copyright © 2016 CuiMingyu. All rights reserved.
//

import UIKit

class MCRotateTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey),
            toView = transitionContext.viewForKey(UITransitionContextToViewKey),
            fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
            toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
            containerView = transitionContext.containerView() else {
                return
        }
        
        let transitionDuration = self.transitionDuration(transitionContext)
        
        let isPresenting = (toViewController.presentingViewController == fromViewController)
        
        let angle = isPresenting ? -CGFloat(M_PI)/2 : CGFloat(M_PI)/2
        let transform = CGAffineTransformMakeRotation(angle)
        
        let rotateView = isPresenting ? toView : fromView
        let originFrame = rotateView.frame
        let anchorPointY = (rotateView.frame.height + rotateView.frame.width/2.0)/rotateView.frame.height
        rotateView.layer.anchorPoint = CGPoint(x: 0.5, y: anchorPointY)
        rotateView.frame = originFrame
        
        if isPresenting {
            toView.transform = transform
            containerView.addSubview(toView)
        } else {
            containerView.insertSubview(toView, belowSubview: fromView)
        }
        
        let animationEaseOption = isPresenting ? UIViewAnimationOptions.CurveEaseOut : .CurveEaseIn
        UIView.animateWithDuration(transitionDuration, delay: 0.0, options: [animationEaseOption]
            , animations: {
                if isPresenting {
                    toView.transform = CGAffineTransformIdentity
                } else {
                    fromView.transform = transform
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
