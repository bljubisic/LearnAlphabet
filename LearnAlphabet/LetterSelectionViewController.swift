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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var tmpViews: [UIView] = [UIView]()
        for index in 1...10 {
            tmpViews.append(addViewsTo(position: index))
        }
        self.views = tmpViews
    }

    
    func addViewsTo(position index: Int) -> UIView {
        let viewToAdd: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 600))
        viewToAdd.center = self.view.center
        viewToAdd.layer.cornerRadius = 10
        
        // border
        viewToAdd.layer.borderWidth = 1.0
        viewToAdd.layer.borderColor = UIColor.black.cgColor
        viewToAdd.transform = CGAffineTransform(rotationAngle: CGFloat(index) * (CGFloat.pi/60))
        self.view.addSubview(viewToAdd)
        self.view.sendSubview(toBack: viewToAdd)
        return viewToAdd
    }
}
