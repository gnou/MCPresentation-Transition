//
//  MainViewController.swift
//  MCPresentation&Transition
//
//  Created by CuiMingyu on 6/13/16.
//  Copyright © 2016 CuiMingyu. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var showDetailButton: UIButton!
    
    let mcTransitionDelegate = MCTransitionDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showDetailButton.layer.borderWidth = 1.0
        showDetailButton.layer.borderColor = view.tintColor.CGColor
        showDetailButton.layer.cornerRadius = 5.0
        showDetailButton.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "presentDetails" {
            let descinationVC = segue.destinationViewController
            descinationVC.modalPresentationStyle = .Custom
            descinationVC.transitioningDelegate = mcTransitionDelegate
        }
    }

    @IBAction func unwindToMain(sender: UIStoryboardSegue) {
        print("Triggered unwind action")
    }
}
