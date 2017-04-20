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
    
    var initialSmileyCenter : CGPoint!
    
    var newlyCreatedFace: UIImageView!
    
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

    @IBAction func onSmileyPanned(_ panGestureRecognizer: UIPanGestureRecognizer) {
        
        if panGestureRecognizer.state == .began {
            
            // Gesture recognizers know the view they are attached to
            let imageView = panGestureRecognizer.view as! UIImageView
            
            // Create a new image view that has the same image as the one currently panning
            newlyCreatedFace = UIImageView(image: imageView.image)
            
            // Add the new face to the tray's parent view.
            view.addSubview(newlyCreatedFace)
            
            // Initialize the position of the new face.
            newlyCreatedFace.center = imageView.center
            
            // Since the original face is in the tray, but the new face is in the
            // main view, you have to offset the coordinates
            newlyCreatedFace.center.y += trayView.frame.origin.y
            initialSmileyCenter = newlyCreatedFace.center
           
        } else if panGestureRecognizer.state == .changed {
            
            newlyCreatedFace.center = CGPoint(x: initialSmileyCenter.x + panGestureRecognizer.translation(in: self.newlyCreatedFace).x, y: initialSmileyCenter.y + panGestureRecognizer.translation(in: self.newlyCreatedFace).y)
            
            
        } else if panGestureRecognizer.state == .ended {
            
            
        }

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

