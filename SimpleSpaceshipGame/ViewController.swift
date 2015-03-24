//
//  ViewController.swift
//  SimpleSpaceshipGame
//
//  Created by Brian Jordan on 3/23/15.
//  Copyright (c) 2015 Brian Jordan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {

    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var push: UIPushBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior()
        collision = UICollisionBehavior()
        push = UIPushBehavior()
        
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        animator.addBehavior(push)
        
        collision.collisionDelegate = self
        
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "generateSpaceship", userInfo: nil, repeats: true)
        
        var tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        self.view.addGestureRecognizer(tapRecognizer)
        
        self.push.pushDirection = CGVectorMake(0, -1);
    }
    
    func handleTap(tap: UITapGestureRecognizer) {
        var point: CGPoint = tap.locationInView(self.view)
        
        var bulletView = UIView(frame: CGRectMake(point.x, point.y, 5.0, 5.0))
        bulletView.backgroundColor = UIColor.blackColor()
        
        self.view.addSubview(bulletView)
        collision.addItem(bulletView)
        push.addItem(bulletView)
        
    }
    
    func generateSpaceship() {
        var spaceship = UIImageView(image: UIImage(named: "spaceship"))
        self.view.addSubview(spaceship)
        var boundsWidth:CGFloat = CGRectGetWidth(view.bounds)
        var randomX = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * boundsWidth
        spaceship.center.x = randomX
        gravity.addItem(spaceship)
        collision.addItem(spaceship)
    }

    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint) {
        (item1 as UIView).removeFromSuperview()
        (item2 as UIView).removeFromSuperview()
    }
    
    func collisionBehavior(behavior: UICollisionBehavior, endedContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem) {
        
    }
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying, atPoint p: CGPoint) {
    }
    func collisionBehavior(behavior: UICollisionBehavior, endedContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

