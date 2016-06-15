//
//  MCPresentationController.swift
//  MCPresentation&Transition
//
//  Created by CuiMingyu on 6/15/16.
//  Copyright © 2016 CuiMingyu. All rights reserved.
//

import UIKit

class MCPresentationController: UIPresentationController {
    
    private var dimmingView: UIView!
    
    /// Presented view will only cover partial screen,
    /// there is a gap between the top of screen and the top of presented view,
    /// and this is the height of the gap
    var topMargin: CGFloat!
    
    init(presentedViewController: UIViewController, presentingViewController: UIViewController, topMargin: CGFloat = 64.0) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
        
        self.topMargin = topMargin
        
        // Must set presented VC's modalPresentationStyle to "Custom"
        presentedViewController.modalPresentationStyle = .Custom
        
        // Create the dimming view and set its initial appearance.
        dimmingView = UIView()
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.38)
        dimmingView.alpha = 0.0
    }
    
    // MARK: Presentation Process
    
    /**
     Can add custom views to the view hierarhcy and configure the animations for those views
     */
    override func presentationTransitionWillBegin() {
        
        guard let containerView = containerView else { return }
        
        dimmingView.frame = containerView.bounds
        dimmingView.alpha = 0.0
        dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dimmingViewTapped(_:))))
        containerView.insertSubview(dimmingView, atIndex: 0)
        
        if let transitionCoordinator = presentedViewController.transitionCoordinator() {
            transitionCoordinator.animateAlongsideTransition({ (transitionCoordinatorContext) in
                self.dimmingView.alpha = 1.0
                }, completion: nil)
        } else {
            dimmingView.alpha = 1.0
        }
    }
    
    func dimmingViewTapped(gestureRecognizer: UITapGestureRecognizer) {
        presentingViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func presentationTransitionDidEnd(completed: Bool) {
        if !completed {
            dimmingView.removeFromSuperview()
        }
    }
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        if let containerViewBounds = containerView?.bounds {
            let rect = CGRect(x: containerViewBounds.origin.x, y: containerViewBounds.origin.y + topMargin, width: containerViewBounds.width, height: containerViewBounds.height - self.topMargin)
            return rect
        }
        
        return CGRectZero
    }
    
    // MARK: During transition animations
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        dimmingView.frame = containerView!.bounds
    }
    
    // MARK: Dismissal Process
    
    override func dismissalTransitionWillBegin() {
        if let transitionCoordinator = presentedViewController.transitionCoordinator() {
            transitionCoordinator.animateAlongsideTransition({ (transitionCoordinatorContext) in
                self.dimmingView.alpha = 0.0
                }, completion: nil)
        } else {
            dimmingView.alpha = 0.0
        }
    }
    
    override func dismissalTransitionDidEnd(completed: Bool) {
        if completed {
            dimmingView.removeFromSuperview()
        }
    }
    
}
