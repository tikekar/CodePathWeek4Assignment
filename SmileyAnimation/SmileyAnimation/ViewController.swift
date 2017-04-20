//
//  ViewController.swift
//  SmileyAnimation
//
//  Created by Gauri Tikekar on 4/19/17.
//  Copyright © 2017 Gauri Tikekar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint!
    var trayCenterWhenOpened: CGPoint!
    var trayCenterWhenClosed: CGPoint!
    
    @IBAction func didTapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        if trayView.center == trayCenterWhenClosed {
            // open
            trayView.center = trayCenterWhenOpened
        }
        else {
            //close
            trayView.center = trayCenterWhenClosed
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        trayCenterWhenClosed = trayView.center
        trayCenterWhenOpened = CGPoint(x: trayView.center.x, y: self.view.frame.height - trayView.frame.height/2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onTrayPanGesture(_ panGestureRecognizer: UIPanGestureRecognizer) {
        // Absolute (x,y) coordinates in parent view (parentView should be
        // the parent view of the tray)
        let point = panGestureRecognizer.location(in: self.view)
        
        if panGestureRecognizer.state == .began {
            
            print("Gesture began at: \(point)")
            trayOriginalCenter = trayView.center
        } else if panGestureRecognizer.state == .changed {
            
            print("Gesture changed at: \(point)")
         //   trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + panGestureRecognizer.translation(in: self.trayView).y)
            
            
        } else if panGestureRecognizer.state == .ended {
            print("Gesture ended at: \(point)")
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                if panGestureRecognizer.velocity(in: self.trayView).y > 0
                {
                    //moving down
                    self.trayView.center = self.trayCenterWhenClosed
                }
                else {
                    //moving up
                    self.trayView.center = self.trayCenterWhenOpened
                }

            }, completion: nil)
        }
    }
    
}

