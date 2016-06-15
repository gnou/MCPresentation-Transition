//
//  DetailViewController.swift
//  MCPresentation&Transition
//
//  Created by CuiMingyu on 6/13/16.
//  Copyright © 2016 CuiMingyu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
//    var gesture: UIScreenEdgePanGestureRecognizer?
    @IBOutlet weak var bottomButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bottomButton.layer.borderWidth = 1.0
        bottomButton.layer.borderColor = view.tintColor.CGColor
        bottomButton.layer.cornerRadius = 5.0
        bottomButton.clipsToBounds = true
        
        // Do any additional setup after loading the view.
        let leftGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.handleEdgePanGestureRecognizer(_:)))
        leftGesture.edges = UIRectEdge.Left
        view.addGestureRecognizer(leftGesture)
        let rightGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.handleEdgePanGestureRecognizer(_:)))
        rightGesture.edges = UIRectEdge.Right
        view.addGestureRecognizer(rightGesture)
    }
    
    func handleEdgePanGestureRecognizer(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        performSegueWithIdentifier("BackToMain", sender: gestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let transitionDelegate = navigationController?.transitioningDelegate as? MCTransitionDelegate {
            if let gestureRecognizer = sender as? UIScreenEdgePanGestureRecognizer where gestureRecognizer.state == .Began {
                transitionDelegate.edgePanGestureRecognizer = gestureRecognizer
                transitionDelegate.targetEdge = gestureRecognizer.edges
            } else {
                transitionDelegate.edgePanGestureRecognizer = nil
                transitionDelegate.targetEdge = nil
            }
        }
    }
}
