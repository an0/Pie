//
//  ViewController.swift
//  Pie
//
//  Created by Ling Wang on 9/4/15.
//  Copyright © 2015 Moke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var animated = false
    var pie1: PieView!
    var pie2: PieView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animated = true
        
        view.backgroundColor = UIColor.blackColor()

        pie1 = PieView()
        // UIView.backgroundColor is nil by default but will be rendered as black in drawing APIs. Black background will make a big visual difference from clear blackground in the results of dynamic drawing of animation. Set animated to true/false and compare the results carefully to see that animation with black background results in relatively coarse edges of the pie — not only during the animation but also the final drawing.
        pie1.progress = 0
        view.addSubview(pie1)
        pie1.translatesAutoresizingMaskIntoConstraints = false
        pie1.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        pie1.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor, constant: -50).active = true
        pie1.widthAnchor.constraintEqualToConstant(24).active = true
        pie1.heightAnchor.constraintEqualToConstant(24).active = true
        
        pie2 = PieView()
        pie2.backgroundColor = UIColor.clearColor()
        pie2.progress = 0
        view.addSubview(pie2)
        pie2.translatesAutoresizingMaskIntoConstraints = false
        pie2.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        pie2.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor, constant: 50).active = true
        pie2.widthAnchor.constraintEqualToConstant(24).active = true
        pie2.heightAnchor.constraintEqualToConstant(24).active = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        pie1.setProgress(0.7, animated: animated)
        pie2.setProgress(0.7, animated: animated)
    }

}

