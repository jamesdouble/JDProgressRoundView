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
        JD = JDProgressRoundView(frame: JDView.frame, howtoincrease: .water)
        self.view.addSubview(JD)
    }
   
    @IBAction func changetype(_ sender: AnyObject) {
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

