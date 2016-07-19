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
    var currentLine: [CGPoint] = [CGPoint]()
    var prevLine: [CGPoint] = [CGPoint]()
    
    var rules: [rule] = [rule]()
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var tempImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let ruleStraightLineSlantedRight: rule = { (prevLine, currentLine) in
            let firstX = currentLine[0].x
            let lastX = currentLine.last!.x
            let firstY = currentLine[0].y
            let lastY = currentLine.last!.y
            
            let maxX = currentLine.reduce(0) { (total, point) in max(point.x, total) }
            
            return (((lastX - firstX) < 150) && ((lastY - firstY) > 50) && (maxX == firstX))
        }
        
        let ruleStraightLineSlantedLeft: rule = { (prevLine, currentLine) in
            let currentFirstPoint = currentLine[0]
            let prevFirstPoint = prevLine[0]
            let currentLastPoint = currentLine.last!
            let prevLastPoint = prevLine.last!
            
            let maxX = currentLine.reduce(0) { (total, point) in max(point.x, total)}
            
            return ( ( (abs(currentFirstPoint.x - prevFirstPoint.x) < 5) && (abs(currentFirstPoint.y - prevFirstPoint.y) < 5)) &&
                (maxX == currentLastPoint.x) && (abs(currentLastPoint.x - prevLastPoint.x) > 50))
            
            
        }
        
        let ruleStraightLineHorizontal: rule = { (prevLine, currentLine) in
            let prevFirstPoint = prevLine[0]
            let prevLastPoint = prevLine.last!
            let currentFirstPoint = currentLine[0]
            let currentLastPoint = currentLine.last!
            
            let maxY = currentLine.reduce(0) {(total, point) in max(point.y, total)}
            
            return ( ( (abs(maxY - currentFirstPoint.y) < 20) && ((prevFirstPoint.x - currentFirstPoint.x) > (prevLastPoint.x - prevFirstPoint.x))
                && (currentLastPoint.x >= prevLastPoint.x)))
            
        }

        rules = [ruleStraightLineSlantedRight, ruleStraightLineSlantedLeft, ruleStraightLineHorizontal]
        
        
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
            currentLine.append(lastPoint)
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
            currentLine.append(currentPoint)
            // 7
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if !swiped {
            // draw a single point
            drawLineFrom(lastPoint, toPoint: lastPoint)
        }
        
        
        
        let ruleOneLetterA: Bool = rules[0](prevLine, currentLine)
        let ruleTwoLetterA: Bool = rules[1](prevLine, currentLine)
        let ruleThreeLetterA: Bool = rules[2](prevLine, currentLine)
        
        
        
        print(ruleOneLetterA)
        
        
        let correct: [Bool] = currentLine.map {point in
            let firstPoint = currentLine[0]
            let lastPoint = currentLine.last!
            
            let y = point.y
            let x = point.x
            
            let calculatedY = ((x - firstPoint.x)/(lastPoint.x - firstPoint.x)) * (lastPoint.y - firstPoint.y) + firstPoint.y
            
            return (10 >= abs(calculatedY - y))
        }
        
        for (point, cor) in zip(currentLine, correct) {
            
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
        
        let maxX = currentLine.reduce(0) {(total, point) in max(point.x, total) }
        
        prevLine = currentLine
        
        currentLine = [CGPoint]()
        
        
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

