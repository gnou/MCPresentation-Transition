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
    
    /// Set this to be the gesture recognizer which will drive the interactivity for interactive transition
    var edgePanGestureRecognizer: UIScreenEdgePanGestureRecognizer?
    var targetEdge: UIRectEdge?

    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return coverVerticalTransitionAnimator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if let _ = edgePanGestureRecognizer,
            targetEdge = targetEdge {
            return MCRotateDismissTransitionAnimator(targetEdge: targetEdge)
        }
        return coverVerticalTransitionAnimator
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let gestureRecognizer = edgePanGestureRecognizer,
            targetEdge = targetEdge {
            return MCSwipeInteractiveTransition(edgePanGestureRecognizer: gestureRecognizer, edgeForDragging: targetEdge)
        }
        return nil
    }
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return MCPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
}
