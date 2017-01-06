//
//  LetterSelectionViewController.swift
//  LearnAlphabet
//
//  Created by Bratislav Ljubisic on 12/28/16.
//  Copyright © 2016 Bratislav Ljubisic. All rights reserved.
//

import UIKit

class LetterSelectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private var views: [UIView] = []
    private let colors: [UIColor] = [UIColor.black, UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow, UIColor.cyan, UIColor.brown, UIColor.gray, UIColor.magenta, UIColor.orange]
    private var distance: CGFloat = 0.0
    private var startY: CGFloat = 0.0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var tmpViews: [UIView] = [UIView]()
        for index in 1...10 {
            tmpViews.append(addViewsTo(position: index))
        }
        self.views = tmpViews
        setupGestures()
        
    }
    
    func setupGestures() {
        let pan = UIPanGestureRecognizer(target:self, action:#selector(self.pan(_:)))
        pan.maximumNumberOfTouches = 1
        pan.minimumNumberOfTouches = 1
        self.view.addGestureRecognizer(pan)
    }

    func addViewsTo(position index: Int) -> UIView {
        let viewToAdd: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 600))
        viewToAdd.center = self.view.center
        viewToAdd.layer.cornerRadius = 10
        
        // border
        viewToAdd.layer.borderWidth = 1.0
        viewToAdd.layer.borderColor = UIColor.black.cgColor
        //viewToAdd.transform = CGAffineTransform(rotationAngle: CGFloat(index) * (CGFloat.pi/60))
        // Set vertical effect
        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y",
                                                               type: .tiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -10 * (10 - index)
        verticalMotionEffect.maximumRelativeValue = 10 * (10 - index)
        
        // Create group to combine both
        let group = UIMotionEffectGroup()
        group.motionEffects = [verticalMotionEffect]
        
        // Add both effects to your view
        viewToAdd.addMotionEffect(group)
        viewToAdd.backgroundColor = colors[index - 1]
        self.view.addSubview(viewToAdd)
        self.view.sendSubview(toBack: viewToAdd)
        
        return viewToAdd
    }
    
    func pan(_ rec:UIPanGestureRecognizer) {
        let p:CGPoint = rec.location(in: self.view)
        let center:CGPoint = self.view.center
        
        if(startY == 0.0) {
            startY = p.y
        } else {
            distance = p.y - startY
        }

        switch rec.state {
        case .began:
            print("began")
            
        case .changed:
            print("distance: \(distance)")
            var index = 0
            for tmpView in views {
                tmpView.center.y = center.y + (distance / CGFloat(index+1))
                index += 1
            }

            
        case .ended:
            print("Ended")
            startY = CGFloat(0.0)
            if abs(distance) > 150 {
                self.view.sendSubview(toBack: views[0])
                views.append(views.removeFirst())
            }
            distance = 0.0
            for tmpView in views {
                tmpView.center = center
            }
        case .possible:
            print("possible")
        case .cancelled:
            print("cancelled")
            startY = CGFloat(0.0)
            distance = 0.0
            for tmpView in views {
                tmpView.center = center
            }
        case .failed:
            print("failed")
            startY = CGFloat(0.0)
            distance = 0.0
            for tmpView in views {
                tmpView.center = center
            }
        }
        
    }
}
