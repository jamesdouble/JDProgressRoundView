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
        JD = JDProgressRoundView(frame: self.JDView.frame, howtoincrease: .Water, ProgressColor: UIColor(red: 0.11, green: 0.88, blue: 0.95, alpha: 1.0))
        self.view.addSubview(JD)
    }
   
    @IBAction func changetype(_ sender: AnyObject) {
        
        if(JD.InnerView?.IncreaseType == .DownToTop)
        {
        JD.setTypes(change: .Loop)
        }
        else{
        JD.setTypes(change: .DownToTop)
        }
 
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

