//
//  ViewController.swift
//  ProgressRoundView
//
//  Created by waninuser on 2016/10/11.
//  Copyright © 2016年 waninuser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var JDView: UIView!
    var JD:JDProgressRoundView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        JD = JDProgressRoundView(frame: JDView.frame, howtoincrease: .heartBeat, ProgressColor:  UIColor(red: 0.96, green: 0.85, blue: 0.95, alpha: 1.0), BorderWidth: 13)
        self.view.addSubview(JD)
        
        //heart [UIColor colorWithRed:0.96 green:0.85 blue:0.95 alpha:1.0]
        //Water Color UIColor(red: 0.11, green: 0.88, blue: 0.95, alpha: 1.0)
    }
   
    @IBAction func changetype(_ sender: AnyObject) {
        
        if(JD.InnerView?.IncreaseType == .downToTop)
        {
        JD.setTypes(.loop)
        }
        else{
        JD.setTypes(.downToTop)
        }
 
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

