//
//  JDProgressRoundView.swift
//  ProgressRoundView
//
//  Created by waninuser on 2016/10/11.
//  Copyright © 2016年 waninuser. All rights reserved.
//

import UIKit



class JDProgressRoundView:UIView{
    
    var InnerView:JDInnerView?
    var Border:JDRoundLayer?
    
    init (frame: CGRect,howtoincrease t:types) {
        super.init(frame: frame)
        //點擊事件
        let SingleTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(JDProgressRoundView.TapView))
        self.addGestureRecognizer(SingleTap)
        
        //外筐
        Border = JDRoundLayer()
        Border?.DrawCircle(theBounds: self.frame, Stroke_Color: UIColor.black.cgColor,percent: 100.0)
        layer.addSublayer(Border!)
        
        //內進度
        var InnerFrame:CGRect = self.frame
        InnerFrame.origin.x = 0.0
        InnerFrame.origin.y = 0.0
        InnerView = JDInnerView(frame: InnerFrame, howtoincrease: t,ProgressColor: UIColor.red)
        InnerView?.DrawInnerLayer()
        self.addSubview(InnerView!)
    }
    
    init (frame: CGRect,howtoincrease t:types,ProgressColor c:UIColor) {
        super.init(frame: frame)
        //點擊事件
        let SingleTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(JDProgressRoundView.TapView))
        self.addGestureRecognizer(SingleTap)
        
        //外筐
        Border = JDRoundLayer()
        Border?.DrawCircle(theBounds: self.frame, Stroke_Color: UIColor.black.cgColor,percent: 100.0)
        layer.addSublayer(Border!)
        
        //內進度
        var InnerFrame:CGRect = self.frame
        InnerFrame.origin.x = 0.0
        InnerFrame.origin.y = 0.0
        InnerView = JDInnerView(frame: InnerFrame, howtoincrease: t,ProgressColor: c)
        InnerView?.DrawInnerLayer()
        self.addSubview(InnerView!)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //點擊事件
        let SingleTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(JDProgressRoundView.TapView))
        self.addGestureRecognizer(SingleTap)
        
        //外筐
        Border = JDRoundLayer()
        Border?.DrawCircle(theBounds: self.frame, Stroke_Color: UIColor.black.cgColor,percent: 100.0)
        layer.addSublayer(Border!)
        
        //內進度
        var InnerFrame:CGRect = self.frame
        InnerFrame.origin.x = 0.0
        InnerFrame.origin.y = 0.0
        InnerView = JDInnerView(frame: InnerFrame)
        InnerView?.DrawInnerLayer()
        self.addSubview(InnerView!)
        
    }
    
    
    
    
    func setProgress(p:CGFloat, animated: Bool)
    {
        if(InnerView != nil)
        {
        InnerView?.progress = p - 5.0
        InnerView?.JDHasBeenTap(animated: animated)
        }
    }
    
    
    func setTypes(change:types)
    {
        if(InnerView?.IncreaseType == .Loop)
        {
            InnerView?.ProgressRoundLayer.removeFromSuperlayer()
        }
        else{
            InnerView?.ProgressInnerLayer.removeFromSuperlayer()
        }
        InnerView?.IncreaseType = change
        InnerView?.progress = 0.0
        InnerView?.ProgressLabel?.removeFromSuperview()
        InnerView?.DrawInnerLayer()
    }
    
    func TapView(){
        InnerView?.JDHasBeenTap(animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}






















