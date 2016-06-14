//
//  MCSwipeInteractiveTransition.swift
//  MCPresentation&Transition
//
//  Created by CuiMingyu on 6/14/16.
//  Copyright © 2016 CuiMingyu. All rights reserved.
//

import UIKit

class MCSwipeInteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    init(edgePanGestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        super.init()
        self.edgePanGestureRecognizer = edgePanGestureRecognizer
        self.edgePanGestureRecognizer?.addTarget(self, action: #selector(self.handleGestureUpdate(_:)))
    }
    
    deinit {
        self.edgePanGestureRecognizer?.removeTarget(self, action: #selector(self.handleGestureUpdate(_:)))
    }
    
    var transitionContext: UIViewControllerContextTransitioning!
    var edgePanGestureRecognizer: UIScreenEdgePanGestureRecognizer?
    
    override func startInteractiveTransition(transitionContext: UIViewControllerContextTransitioning) {
        // Always call super first.
        super.startInteractiveTransition(transitionContext)
        
        // Save the transitionContext for later.
        self.transitionContext = transitionContext
    }
    
    func percentageForGestureRecognizer(gestureRecognizer: UIScreenEdgePanGestureRecognizer) -> CGFloat {
        if let containerView = transitionContext.containerView() {
            let locationInContainerView = gestureRecognizer.locationInView(containerView)
            let containerWidth = containerView.bounds.size.width
            let percentage = locationInContainerView.x / containerWidth
            return percentage
        }
        return 0.0
    }
    
    func handleGestureUpdate(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        switch gestureRecognizer.state {
        case .Began:
            break
        case .Changed:
            self.updateInteractiveTransition(percentageForGestureRecognizer(gestureRecognizer))
        case .Ended:
            if percentageForGestureRecognizer(gestureRecognizer) > 0.5 {
                finishInteractiveTransition()
            } else {
                cancelInteractiveTransition()
            }
        default:
            cancelInteractiveTransition()
            break
        }
    }

}
