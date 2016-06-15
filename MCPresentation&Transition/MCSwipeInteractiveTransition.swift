//
//  MCSwipeInteractiveTransition.swift
//  MCPresentation&Transition
//
//  Created by CuiMingyu on 6/14/16.
//  Copyright © 2016 CuiMingyu. All rights reserved.
//

import UIKit

class MCSwipeInteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    /// Set this to the edge gesture recognizer which will drive the interactivity
    var edgePanGestureRecognizer: UIScreenEdgePanGestureRecognizer!
    
    /// The starting edge for the gesture
    var targetEdge: UIRectEdge!
    
    /// Saved when interactive transition start, will be used for gesture recognizer handler
    private var transitionContext: UIViewControllerContextTransitioning!
    
    init(edgePanGestureRecognizer: UIScreenEdgePanGestureRecognizer, edgeForDragging edge: UIRectEdge) {
        super.init()
        assert([UIRectEdge.Left, UIRectEdge.Right].contains(edge), "edgeForDragging must be one of the .Left, .Right")
        
        self.targetEdge = edge
        self.edgePanGestureRecognizer = edgePanGestureRecognizer
        self.edgePanGestureRecognizer?.addTarget(self, action: #selector(self.handleGestureUpdate(_:)))
    }
    
    deinit {
        self.edgePanGestureRecognizer?.removeTarget(self, action: #selector(self.handleGestureUpdate(_:)))
    }
    
    override func startInteractiveTransition(transitionContext: UIViewControllerContextTransitioning) {
        // Always call super first.
        super.startInteractiveTransition(transitionContext)
        
        // Save the transitionContext for later.
        self.transitionContext = transitionContext
    }
    
    /**
     Returns the offset of the edge pan gesutre recognizer from the edge of the
     screen as a percentage of the transition container view's width.
     */
    func percentageForGestureRecognizer(gestureRecognizer: UIScreenEdgePanGestureRecognizer) -> CGFloat {
        if let containerView = transitionContext.containerView() {
            let containerWidth = containerView.bounds.size.width
            
            let xLocationInContainerView = gestureRecognizer.locationInView(containerView).x
            let offset = targetEdge == UIRectEdge.Left ? xLocationInContainerView : containerWidth - xLocationInContainerView
            
            let percentage = offset / containerWidth
            return percentage
        }
        return 0.0
    }
    
    func handleGestureUpdate(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        switch gestureRecognizer.state {
        case .Began:
            // The 'Began' state is handled by the view controllers, it'll trigger the presentation or dismissal
            break
        case .Changed:
            self.updateInteractiveTransition(percentageForGestureRecognizer(gestureRecognizer))
        case .Ended:
            if percentageForGestureRecognizer(gestureRecognizer) >= 0.5 {
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
