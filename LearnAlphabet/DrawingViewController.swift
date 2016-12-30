//
//  ViewController.swift
//  LearnAlphabet
//
//  Created by Bratislav Ljubisic on 3/12/16.
//  Copyright © 2016 Bratislav Ljubisic. All rights reserved.
//

import UIKit

class DrawingViewController: UIViewController {
    
    
    
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
    
    var ruleCounter = 0
    
    var rules: [rule] = [rule]()
    var rulesResult: [Bool] = [Bool]()
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var tempImageView: UIImageView!
    

    
    func maxx(_ currentPoint: CGPoint, maxPoint: CGPoint) -> CGPoint {
        return ((currentPoint.x > maxPoint.x) ? currentPoint: maxPoint)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let ruleStraightLineSlantedRight: rule = { (prevLine, currentLine) in
            let first = currentLine[0]
            let last = currentLine.reduce(CGPoint(x: 0, y: 0)) { (point, total) in
                return ((point.y > total.y) ? point : total)
                
            }
            
            let maxX = currentLine.reduce(CGPoint(x: 0, y: 0)) { (point, total) in
                return ((point.x > total.x) ? point : total)
            
            }
            
            return (((last.x - first.x) < 150) && ((last.y - first.y) > 50) && (maxX.x == first.x))
        }
        
        let ruleStraightLineSlantedLeft: rule = { (prevLine, currentLine) in
            let currentFirstPoint = currentLine[0]
            let prevFirstPoint = prevLine[0]
            let currentLastPoint = currentLine.reduce(CGPoint(x: 0, y: 0)) { (point, total) in
                return ((point.y > total.y) ? point : total)
                
            }

            let prevLastPoint = prevLine.reduce(CGPoint(x: 0, y: 0)) { (point, total) in
                return ((point.y > total.y) ? point : total)
                
            }

            
            let maxX = currentLine.reduce(0) { (total, point) in max(point.x, total)}
            
            return ( ( (abs(currentFirstPoint.x - prevFirstPoint.x) < 5) && (abs(currentFirstPoint.y - prevFirstPoint.y) < 5)) &&
                (maxX == currentLastPoint.x) && (abs(currentLastPoint.x - prevLastPoint.x) > 50))
            
            
        }
        
        let ruleStraightLineHorizontal: rule = { (prevLine, currentLine) in
            let prevFirstPoint = prevLine[0]
            let prevLastPoint = prevLine.reduce(CGPoint(x: 0, y: 0)) { (point, total) in
                return ((point.y > total.y) ? point : total)
                
            }

            let currentFirstPoint = currentLine[0]
            let currentLastPoint = currentLine.reduce(CGPoint(x: 0, y: 0)) { (point, total) in
                return ((point.x > total.x) ? point : total)
                
            }


            
            let maxY = currentLine.reduce(0) {(total, point) in max(point.y, total)}
            
            return ( ( (abs(maxY - currentFirstPoint.y) < 20) && ((currentLastPoint.x - currentFirstPoint.x) > (prevLastPoint.x - prevFirstPoint.x)*2)
                && (currentLastPoint.x >= prevLastPoint.x)))
            
        }
        
        rules = [ruleStraightLineSlantedRight, ruleStraightLineSlantedLeft, ruleStraightLineHorizontal]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first {
            lastPoint = touch.location(in: self.view)
            currentLine.append(lastPoint)
        }
    }
    
    func drawLineFrom(_ fromPoint: CGPoint, toPoint: CGPoint) {
        
        // 1
        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        // 2
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        // 3
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(brushWidth)
        context?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        // 4
        context?.strokePath()
        
        // 5
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = opacity
        UIGraphicsEndImageContext()
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 6
        swiped = true
        if let touch = touches.first {
            let currentPoint = touch.location(in: view)
            drawLineFrom(lastPoint, toPoint: currentPoint)
            currentLine.append(currentPoint)
            // 7
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if !swiped {
            // draw a single point
            drawLineFrom(lastPoint, toPoint: lastPoint)
        }
        
        rulesResult.append(rules[ruleCounter](prevLine, currentLine))
        
        
        
        print(rulesResult[ruleCounter])
        
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
            tempImageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
            
            let circleSize: CGFloat = 10
            let pt = CGPoint(x: point.x - circleSize/2, y: point.y - circleSize/2)
            let circOutline = CGRect(x: pt.x, y: pt.y, width: circleSize, height: circleSize)
            
            var color = UIColor.red.cgColor
            if cor {
                color = UIColor.green.cgColor
            }
            context?.setFillColor(color)
            context?.fill(circOutline)
            context?.strokePath()
            tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
        }
        
        prevLine = currentLine
        
        currentLine = [CGPoint]()
        
        ruleCounter += 1
        
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

    func checkLine(_ line: [CGPoint]) -> [Bool] {
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

