//
//  JDLayerClass.swift
//  ProgressRoundView
//
//  Created by waninuser on 2016/10/18.
//  Copyright © 2016年 waninuser. All rights reserved.
//

import UIKit

//外面圓圈
class JDRoundLayer:CAShapeLayer{
    
    var halfSize:CGFloat = 0.0
    var desiredLineWidth:CGFloat = 13
    
    override init() {
        super.init()
        self.lineCap = "kCALineCapRound"
        self.lineJoin = "kCALineJoinRound"
        self.lineWidth = desiredLineWidth
    }
    
    init(LineWidth w:CGFloat) {
        super.init()
        self.lineCap = "kCALineCapRound"
        self.lineJoin = "kCALineJoinRound"
        self.lineWidth = w
        desiredLineWidth = w
    }
    
    
    
    func getPath(_ percent:CGFloat) -> CGPath{
    
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x:halfSize,y:halfSize),
            radius: CGFloat( halfSize - (desiredLineWidth/2) ),
            startAngle: CGFloat(Double.pi * 1.5),
            endAngle:CGFloat(Double.pi * 1.5) + CGFloat(Double.pi * 2) * percent/100 ,
            clockwise: true)
        
        circlePath.lineCapStyle = .round
        circlePath.lineJoinStyle = .round
        
        return circlePath.cgPath
    }
    
    
    func DrawCircle(_ theBounds:CGRect,Stroke_Color:CGColor,percent:CGFloat){
        halfSize = min( theBounds.size.width/2, theBounds.size.height/2)
        let circlePath = getPath(percent)
        self.path = circlePath
        self.lineCap = "kCALineCapRound"
        self.lineJoin = "kCALineJoinRound"
        self.fillColor = UIColor.clear.cgColor
        self.strokeColor = Stroke_Color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}


//裡面的圖層
class JDInnerLayer:CAShapeLayer{
    
    var halfSize:CGFloat = 0.0
    var ParentInnerView:JDInnerView?
    var layeranimation:JDLayerAnimation?
    var HeartShadow:Bool = false
    
    override init() {
        super.init()
    }
    
    init(ParentControll inner:JDInnerView) {
        super.init()
        ParentInnerView = inner
    }
    
    //DrawCircle:: 才會使用到
    
    func DrawCircle(_ theBounds:CGRect,FillingColor c:UIColor,percent:CGFloat){
        halfSize = min( theBounds.size.width/2, theBounds.size.height/2)
        let desiredLineWidth:CGFloat = 13
        let circlePath:CGPath = JDBezierPathClass.getPath(percent, innerlayer: self, originalRect: theBounds)
        self.path = circlePath
        self.fillColor = c.cgColor
        self.strokeColor = UIColor.clear.cgColor
        self.lineWidth = desiredLineWidth
        if(ParentInnerView?.IncreaseType == .water || ParentInnerView?.IncreaseType == .heartBeat)
        {
            //遮罩
            let DownCircleMask:JDInnerLayer = JDInnerLayer()
            DownCircleMask.DrawCircle(theBounds,FillingColor: c, percent: 100.0)
            self.mask = DownCircleMask
            layeranimation = JDLayerAnimation(innerlayer: self)
            tickAnimation(FillingColor: c, percent: percent)
        }
    }
    
    func tickAnimation(FillingColor c:UIColor,percent:CGFloat){
        if(ParentInnerView?.IncreaseType == .water)
        {
        layeranimation?.WaterLayerAnimation(FillingColor: c, percent: percent)
        }
        if(ParentInnerView?.IncreaseType == .heartBeat && !(HeartShadow))
        {
        layeranimation?.HeartBeatAnimation(FillingColor: c, percent: percent)
        }
    }
    
    
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
