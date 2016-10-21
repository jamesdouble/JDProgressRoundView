//
//  JDInnerViewClass.swift
//  ProgressRoundView
//
//  Created by waninuser on 2016/10/11.
//  Copyright © 2016年 waninuser. All rights reserved.
//

import UIKit

enum types {
    case DownToTop
    case Loop
    case GrownCircle
    case Water
}


//包裝所有進度％相關
class JDInnerView:UIView{
    
    var bgColor:UIColor!
    var IncreaseType:types = .DownToTop
    var progress:CGFloat = 0.0
    var ProgressLabel:UILabel?
    var ProgressInnerLayer:JDInnerLayer!
    var ProgressRoundLayer:JDRoundLayer!
    
    init(frame: CGRect,howtoincrease type:types,ProgressColor color:UIColor){
        super.init(frame: frame)
        bgColor = color
        IncreaseType = type
        progress = 0.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bgColor = UIColor.red
        IncreaseType = .DownToTop
        progress = 0.0
    }
    
    func JDHasBeenTap(animated: Bool){
        progress += 5.0
        
        if(IncreaseType == .Loop )
        {
            if(progress != 0.0)
            {
                let a:CABasicAnimation = CABasicAnimation(keyPath: "path")
                a.duration = 1.0
                a.fromValue = ProgressRoundLayer.path!
                a.toValue = ProgressRoundLayer.getPath(percent: progress)
                ProgressRoundLayer.add(a, forKey: "path")
                ProgressRoundLayer.path = ProgressRoundLayer.getPath(percent: progress)
            }
            else{
                ProgressRoundLayer.removeAllAnimations()
                ProgressRoundLayer.path = ProgressRoundLayer.getPath(percent: 0.0)
            }
            
        }
        else if(IncreaseType == .DownToTop || IncreaseType == .GrownCircle){
            
            if(progress != 0.0)
            {
                
                let a:CABasicAnimation = CABasicAnimation(keyPath: "path")
                a.duration = 1.0
                a.fromValue = ProgressInnerLayer.path!
                a.toValue = ProgressInnerLayer.getPath(percent: progress)
                ProgressInnerLayer.add(a, forKey: "path")
                ProgressInnerLayer.path = ProgressInnerLayer.getPath(percent: progress)
            }
            else{
                ProgressInnerLayer.removeAllAnimations()
                ProgressInnerLayer.path = ProgressInnerLayer.getPath(percent: 0.0)
            }
        }
        else if(IncreaseType == .Water)
        {
           ProgressInnerLayer.layeranimation?.timer.invalidate()
            
            if(progress != 0.0)
            {
                let a:CABasicAnimation = CABasicAnimation(keyPath: "path")
                a.duration = 1.0
                a.fromValue = ProgressInnerLayer.path!
                a.toValue = ProgressInnerLayer.getPath(percent: progress)
                ProgressInnerLayer.add(a, forKey: "path")
                ProgressInnerLayer.path = ProgressInnerLayer.getPath(percent: progress)
                
            }
            else{
                ProgressInnerLayer.removeAllAnimations()
                ProgressInnerLayer.path = ProgressInnerLayer.getPath(percent: 0.0)
            }
            ProgressInnerLayer.tickAnimation(FillingColor: bgColor, percent: progress)
        }
        
        ProgressLabel?.text = "  \(progress) %"
        if(progress == 100.0){
            progress = -5.0
        }
        
    }
    
    
    
    /// 畫上裡面得圖層
    func DrawInnerLayer(){
        
        if(IncreaseType == .DownToTop || IncreaseType == .GrownCircle || IncreaseType == .Water)
        {
            ProgressInnerLayer = JDInnerLayer(ParentControll: self)
            ProgressInnerLayer.DrawCircle(theBounds: self.frame, FillingColor: bgColor ,percent: progress)
            layer.addSublayer(ProgressInnerLayer)
        }
        else{
            ProgressRoundLayer = JDRoundLayer()
            ProgressRoundLayer.DrawCircle(theBounds: self.frame, Stroke_Color: bgColor.cgColor,percent: progress)
            layer.addSublayer(ProgressRoundLayer)
        }
        
        //中間百分比
        let LabelFrame:CGRect = CGRect(x: 0.0, y: 0.35 * self.frame.height, width: self.frame.width, height: self.frame.height * 0.3)
        ProgressLabel = UILabel(frame: LabelFrame)
        ProgressLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightThin)
        ProgressLabel?.text = "  \(progress) %"
        ProgressLabel?.textAlignment = .center
        self.addSubview(ProgressLabel!)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

