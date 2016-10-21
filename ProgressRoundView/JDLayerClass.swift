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
    
    override init() {
        super.init()
        self.lineCap = "kCALineCapRound"
        self.lineJoin = "kCALineJoinRound"
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    func getPath(percent:CGFloat) -> CGPath{
        
        let desiredLineWidth:CGFloat = 13
        self.lineWidth = desiredLineWidth
        
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x:halfSize,y:halfSize),
            radius: CGFloat( halfSize - (desiredLineWidth/2) ),
            startAngle: CGFloat(M_PI * 1.5),
            endAngle:CGFloat(M_PI * 1.5) + CGFloat(M_PI * 2) * percent/100 ,
            clockwise: true)
        
        circlePath.lineCapStyle = .round
        circlePath.lineJoinStyle = .round
        
        return circlePath.cgPath
    }
    
    
    func DrawCircle(theBounds:CGRect,Stroke_Color:CGColor,percent:CGFloat){
        halfSize = min( theBounds.size.width/2, theBounds.size.height/2)
        let circlePath = getPath(percent: percent)
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
    
    override init() {
        super.init()
    }
    
    init(ParentControll inner:JDInnerView) {
        super.init()
        ParentInnerView = inner
    }
    
    //DrawCircle:: 才會使用到
    func getPath(percent:CGFloat) -> CGPath{
        
        let desiredLineWidth:CGFloat = 13
        self.lineWidth = desiredLineWidth
        
        var r:CGFloat!
        var s:CGFloat!
        var e:CGFloat!
        var circlePath:UIBezierPath!
        
        if(ParentInnerView?.IncreaseType == .DownToTop)
        {
        r = CGFloat( halfSize - 2 * (desiredLineWidth/2) )
        s = CGFloat( CGFloat(M_PI * 0.5) * (1 - percent/50))
        e = CGFloat( CGFloat(M_PI * 0.5) * (1 + percent/50))
        
        circlePath = UIBezierPath(arcCenter: CGPoint(x:halfSize,y:halfSize),
                                      radius: r,
                                      startAngle: s,
                                      endAngle: e,
                                      clockwise: true)
        circlePath.fill()
        return circlePath.cgPath
            
        }
        if(ParentInnerView?.IncreaseType == .GrownCircle )
        {
            r = CGFloat( (halfSize - 2 * (desiredLineWidth/2)) * percent/100.0 )
            s = CGFloat( 0 )
            e = CGFloat( CGFloat(M_PI * 2) )
            
            circlePath = UIBezierPath(arcCenter: CGPoint(x:halfSize,y:halfSize),
                                      radius: r,
                                      startAngle: s,
                                      endAngle: e,
                                      clockwise: true)
            circlePath.fill()
            return circlePath.cgPath
        }
        if(ParentInnerView?.IncreaseType == .Water)
        {
            let centerY = halfSize * (100.0 - percent)/50
            let steps = 200                 // Divide the curve into steps
            let stepX = (2 * halfSize - 2 * (desiredLineWidth/2))/CGFloat(steps) // find the horizontal step distance
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 0, y: halfSize * 2 ))
            path.addLine(to: CGPoint(x: 0, y: centerY))
        
            for i in 0...steps {
                let x = CGFloat(i) * stepX
                let y = (sin(Double(i) * 0.04) * 8) + Double(centerY)
                path.addLine(to: CGPoint(x: x, y: CGFloat(y)))
            }
            path.addLine(to: CGPoint(x: 2 * halfSize, y: 2 * halfSize))
            path.close()
            let fillColor = UIColor.blue
            fillColor.setFill()
            path.fill()
            return path.cgPath
        }
        
        
        r = CGFloat( halfSize - 2 * (desiredLineWidth/2) )
        s = CGFloat( CGFloat(M_PI * 0.5) * (1 - percent/50))
        e = CGFloat( CGFloat(M_PI * 0.5) * (1 + percent/50))

        circlePath = UIBezierPath(arcCenter: CGPoint(x:halfSize,y:halfSize),
                                      radius: r,
                                      startAngle: s,
                                      endAngle: e,
                                      clockwise: true)
        circlePath.fill()
        return circlePath.cgPath
    }
    
    
    func DrawCircle(theBounds:CGRect,FillingColor c:UIColor,percent:CGFloat){
        halfSize = min( theBounds.size.width/2, theBounds.size.height/2)
        let desiredLineWidth:CGFloat = 13
        let circlePath:CGPath = getPath(percent: percent)
        self.path = circlePath
        self.fillColor = c.cgColor
        self.strokeColor = UIColor.clear.cgColor
        self.lineWidth = desiredLineWidth
        if(ParentInnerView?.IncreaseType == .Water)
        {
            //遮罩
            let DownCircleMask:JDInnerLayer = JDInnerLayer()
            DownCircleMask.DrawCircle(theBounds: theBounds,FillingColor: c, percent: 100.0)
            self.mask = DownCircleMask
            layeranimation = JDLayerAnimation(innerlayer: self)
            tickAnimation(FillingColor: c, percent: percent)
        }
    }
    
    func tickAnimation(FillingColor c:UIColor,percent:CGFloat){
        if(ParentInnerView?.IncreaseType == .Water)
        {
        layeranimation?.WaterLayerAnimation(FillingColor: c, percent: percent)
        }
    }
    
    
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
