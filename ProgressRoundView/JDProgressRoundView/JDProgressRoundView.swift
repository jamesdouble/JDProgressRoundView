//
//  JDProgressRoundView.swift
//  ProgressRoundView
//
//  Created by waninuser on 2016/10/11.
//  Copyright © 2016年 waninuser. All rights reserved.
//

import UIKit

open class JDProgressRoundView:UIView{
    
    var InnerView:JDInnerView?
    var Border:JDRoundLayer?
    
    public init (frame: CGRect,howtoincrease t:types,unit u:String) {
        super.init(frame: frame)
        //點擊事件
        let SingleTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(JDProgressRoundView.TapView))
        self.addGestureRecognizer(SingleTap)
        
        //外筐
        Border = JDRoundLayer()
        Border?.DrawCircle(self.frame, Stroke_Color: UIColor.black.cgColor,percent: 100.0)
        layer.addSublayer(Border!)
        
        //內進度
        var InnerFrame:CGRect = self.frame
        InnerFrame.origin.x = 0.0
        InnerFrame.origin.y = 0.0
        InnerView = JDInnerView(frame: InnerFrame, howtoincrease: t,ProgressColor: UIColor.red,UNIT : u)
        InnerView?.DrawInnerLayer()
        self.addSubview(InnerView!)
    }
    
    public init (frame: CGRect,howtoincrease t:types,ProgressColor c:UIColor,BorderWidth b:CGFloat) {
        super.init(frame: frame)
        //點擊事件
        let SingleTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(JDProgressRoundView.TapView))
        self.addGestureRecognizer(SingleTap)
        
        //外筐
        Border = JDRoundLayer(LineWidth: b)
        Border?.DrawCircle(self.frame, Stroke_Color: UIColor.black.cgColor,percent: 100.0)
        layer.addSublayer(Border!)
        
        //內進度
        var InnerFrame:CGRect = self.frame
        InnerFrame.origin.x = 0.0
        InnerFrame.origin.y = 0.0
        InnerView = JDInnerView(frame: InnerFrame, howtoincrease: t,ProgressColor: c,UNIT : "%")
        InnerView?.DrawInnerLayer()
        self.addSubview(InnerView!)
    }
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        //點擊事件
        let SingleTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(JDProgressRoundView.TapView))
        self.addGestureRecognizer(SingleTap)
        
        //外筐
        Border = JDRoundLayer()
        Border?.DrawCircle(self.frame, Stroke_Color: UIColor.black.cgColor,percent: 100.0)
        layer.addSublayer(Border!)
        
        //內進度
        var InnerFrame:CGRect = self.frame
        InnerFrame.origin.x = 0.0
        InnerFrame.origin.y = 0.0
        InnerView = JDInnerView(frame: InnerFrame)
        InnerView?.DrawInnerLayer()
        self.addSubview(InnerView!)
        
    }
    
    open func setProgress(_ p:CGFloat, animated: Bool)
    {
        if(InnerView != nil)
        {
        InnerView?.progress = p - 5.0
        InnerView?.JDHasBeenTap(animated)
        }
    }
    
    
    open func setTypes(_ change:types)
    {
        if(InnerView?.IncreaseType == .loop)
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
        InnerView?.JDHasBeenTap(true)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}






















