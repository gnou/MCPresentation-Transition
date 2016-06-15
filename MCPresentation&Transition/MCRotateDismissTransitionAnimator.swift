//
//  MCRotateTransitionAnimator.swift
//  MCPresentation&Transition
//
//  Created by CuiMingyu on 6/14/16.
//  Copyright © 2016 CuiMingyu. All rights reserved.
//

import UIKit

class MCRotateDismissTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var targetEdge: UIRectEdge!
    
    convenience init(targetEdge: UIRectEdge!) {
        self.init()
        assert([UIRectEdge.Left, UIRectEdge.Right].contains(targetEdge), "edgeForDragging must be one of the .Left, .Right")
        self.targetEdge = targetEdge
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey) else {
//            toView = transitionContext.viewForKey(UITransitionContextToViewKey),
//            containerView = transitionContext.containerView() else {
                return
        }
        
        let transitionDuration = self.transitionDuration(transitionContext)
        
        let angle = targetEdge == UIRectEdge.Left ? CGFloat(M_PI)/2 : -CGFloat(M_PI)/2
        let transform = CGAffineTransformMakeRotation(angle)
        
        let originFrame = fromView.frame
        let anchorPointY = (fromView.frame.height + fromView.frame.width/2.0)/fromView.frame.height
        fromView.layer.anchorPoint = CGPoint(x: 0.5, y: anchorPointY)
        fromView.frame = originFrame
        
//        containerView.insertSubview(toView, belowSubview: fromView)
        
        UIView.animateWithDuration(transitionDuration, delay: 0.0, options: [.CurveEaseIn]
            , animations: {
                fromView.transform = transform
        }) { (finished) in
            let wasCancelled = transitionContext.transitionWasCancelled()
            if wasCancelled {
//                toView.removeFromSuperview()
            }
            
            transitionContext.completeTransition(!wasCancelled)
        }
    }
}
