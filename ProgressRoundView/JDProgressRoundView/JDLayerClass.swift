//
//  JDLayerClass.swift
//  ProgressRoundView
//
//  Created by waninuser on 2016/10/18.
//  Copyright © 2016年 waninuser. All rights reserved.
//

import UIKit

class JDLayerClass:CAShapeLayer
{
    var InnerViewSize:CGSize!
    var layeranimation:JDLayerAnimation!
    var halfSize:CGFloat{
        get{
            return min( InnerViewSize.width/2, InnerViewSize.height/2)
        }
    }
    
    init(size:CGSize) {
        super.init()
        InnerViewSize = size
        layeranimation = JDLayerAnimation(innerlayer: self)
    }
    
    func resetToZeroPath()
    {
        if let round = self as? JDRoundLayer
        {
            round.path = round.getPath(0.0)
        }
        else if let inner = self as? JDInnerLayer
        {
            inner.path = inner.BezierPath.getPath(0.0)
        }
    }
    
    func JDHasBeenTap(_ animated: Bool,progress:CGFloat)
    {
        layeranimation.LayerGrowning(progress: progress)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func DrawCircle(Stroke_Color:CGColor,percent:CGFloat)
    {

    }
    
}

//外面圓圈
class JDRoundLayer:JDLayerClass
{
    init(LineWidth w:CGFloat,theBounds:CGSize,Stroke_Color:CGColor,percent:CGFloat) {
        super.init(size: theBounds)
        self.lineCap = "kCALineCapRound"
        self.lineJoin = "kCALineJoinRound"
        self.lineWidth = w
        DrawCircle(Stroke_Color: Stroke_Color,percent: percent)
    }
    
    func getPath(_ percent:CGFloat) -> CGPath
    {
        let desiredLineWidth:CGFloat = self.lineWidth
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
    
    override func DrawCircle(Stroke_Color:CGColor,percent:CGFloat){
        super.DrawCircle(Stroke_Color: Stroke_Color, percent: percent)
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
class JDInnerLayer:JDLayerClass{
    var isBeatingLayer:Bool = false
    var IncreaseType:types = .downToTop
    var BezierPath:JDBezierPathClass!
    
    
    init(incresasetypes types:types,theBounds:CGSize,Stroke_Color:CGColor,percent:CGFloat) {
        super.init(size: theBounds)
        IncreaseType = types
        BezierPath = JDBezierPathClass(type: IncreaseType, halfsize: self.halfSize,originalRect: InnerViewSize)
        if(types == .heartBeat)
        {
            layeranimation.BeatingLayer = JDInnerLayer(incresasetypes: .heartBeat, theBounds: theBounds, Stroke_Color: UIColor.red.cgColor, percent: percent * 1.1,isBeatingLayer: true)
            layeranimation.BeatingLayer.opacity = 0.0
        }
        DrawCircle(Stroke_Color: Stroke_Color,percent: percent)
        
    }
    
    //Beating Layer will use this.
    init(incresasetypes types:types,theBounds:CGSize,Stroke_Color:CGColor,percent:CGFloat,isBeatingLayer:Bool) {
        super.init(size: theBounds)
        IncreaseType = types
        self.isBeatingLayer = true
        BezierPath = JDBezierPathClass(type: IncreaseType, halfsize: self.halfSize,originalRect: InnerViewSize)
        DrawCircle(Stroke_Color: Stroke_Color,percent: percent)
    }
    
    //DrawCircle:: 才會使用到
    override func DrawCircle(Stroke_Color:CGColor,percent:CGFloat)
    {
        print(#function)
        let desiredLineWidth:CGFloat = 13
        let circlePath:CGPath = BezierPath.getPath(percent)
        self.path = circlePath
        self.fillColor = Stroke_Color
        self.strokeColor = UIColor.clear.cgColor
        self.lineWidth = desiredLineWidth
        
        if(IncreaseType == .water || IncreaseType == .heartBeat)
        {
            //遮罩
            let DownCircleMask:JDInnerLayer = JDInnerLayer(incresasetypes: .downToTop, theBounds: InnerViewSize, Stroke_Color: Stroke_Color, percent: 100.0)
            self.mask = DownCircleMask
            if(!isBeatingLayer)
            {
                tickAnimation(percent: percent)
            }
        }
    }
    
    func tickAnimation(percent:CGFloat){
        if(IncreaseType == .water)
        {
            layeranimation.WaterLayerAnimation(percent: percent)
        }
        if(IncreaseType == .heartBeat)
        {
            layeranimation.HeartBeatAnimation(percent: percent)
        }
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
