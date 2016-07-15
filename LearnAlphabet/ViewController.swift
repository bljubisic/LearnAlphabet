//
//  ViewController.swift
//  LearnAlphabet
//
//  Created by Bratislav Ljubisic on 3/12/16.
//  Copyright © 2016 Bratislav Ljubisic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    typealias rule = ([CGPoint], [CGPoint]) -> Bool
    
    
    
    var lastPoint = CGPoint.zero
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    var lineDrawn: [CGPoint] = [CGPoint]()
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var tempImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        swiped = false
        if let touch = touches.first {
            lastPoint = touch.locationInView(self.view)
            lineDrawn.append(lastPoint)
        }
    }
    
    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        
        // 1
        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        // 2
        CGContextMoveToPoint(context, fromPoint.x, fromPoint.y)
        CGContextAddLineToPoint(context, toPoint.x, toPoint.y)
        
        // 3
        CGContextSetLineCap(context, CGLineCap.Round)
        CGContextSetLineWidth(context, brushWidth)
        CGContextSetRGBStrokeColor(context, red, green, blue, 1.0)
        CGContextSetBlendMode(context, CGBlendMode.Normal)
        
        // 4
        CGContextStrokePath(context)
        
        // 5
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = opacity
        UIGraphicsEndImageContext()
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // 6
        swiped = true
        if let touch = touches.first {
            let currentPoint = touch.locationInView(view)
            drawLineFrom(lastPoint, toPoint: currentPoint)
            lineDrawn.append(currentPoint)
            // 7
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if !swiped {
            // draw a single point
            drawLineFrom(lastPoint, toPoint: lastPoint)
        }
        
        let correct: [Bool] = lineDrawn.map {point in
            let firstPoint = lineDrawn[0]
            let lastPoint = lineDrawn.last!
            
            let y = point.y
            let x = point.x
            
            let calculatedY = ((x - firstPoint.x)/(lastPoint.x - firstPoint.x)) * (lastPoint.y - firstPoint.y) + firstPoint.y
            
            return (10 >= abs(calculatedY - y))
        }
        
        for (point, cor) in zip(lineDrawn, correct) {
            
            UIGraphicsBeginImageContext(view.frame.size)
            let context = UIGraphicsGetCurrentContext()
            tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
            
            let circleSize: CGFloat = 10
            let pt = CGPointMake(point.x - circleSize/2, point.y - circleSize/2)
            let circOutline = CGRectMake(pt.x, pt.y, circleSize, circleSize)
            
            var color = UIColor.redColor().CGColor
            if cor {
                color = UIColor.greenColor().CGColor
            }
            CGContextSetFillColorWithColor(context, color)
            CGContextFillRect(context, circOutline)
            CGContextStrokePath(context)
            tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
        }
        
        let maxX = lineDrawn.reduce(0) {(total, point) in max(point.x, total) }
        
        lineDrawn = [CGPoint]()
        
        
        /*
        // Merge tempImageView into mainImageView
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        mainImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: 1.0)
        tempImageView.image?.drawInRect(CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.Normal, alpha: opacity)
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        tempImageView.image = nil
        */
        
    }

    func checkLine(line: [CGPoint]) -> [Bool] {
        let firstPoint = line[0]
        let lastPoint = line.last!
        var results: [Bool] = [Bool]()
        
        for point in line {
            let y = point.y
            let x = point.x
            
            let calculatedY = ((x - firstPoint.x)/(lastPoint.x - firstPoint.x)) * (lastPoint.y - firstPoint.y) + firstPoint.y
            
            results.append((20 >= abs(calculatedY - y)))
        }
        return results
    }

}

