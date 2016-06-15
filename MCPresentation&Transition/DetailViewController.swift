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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let leftGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.handleEdgePanGestureRecognizer(_:)))
        leftGesture.edges = UIRectEdge.Left
        view.addGestureRecognizer(leftGesture)
        let rightGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.handleEdgePanGestureRecognizer(_:)))
        rightGesture.edges = UIRectEdge.Right
        view.addGestureRecognizer(rightGesture)
    }
    
    func handleEdgePanGestureRecognizer(gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        if gestureRecognizer.state == .Began {
            if let transitionDelegate = navigationController?.transitioningDelegate as? MCTransitionDelegate {
                transitionDelegate.edgePanGestureRecognizer = gestureRecognizer
                transitionDelegate.targetEdge = gestureRecognizer.edges
                performSegueWithIdentifier("BackToMain", sender: gestureRecognizer)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
