//
//  JDLayerAnimation.swift
//  ProgressRoundView
//
//  Created by waninuser on 2016/10/21.
//  Copyright © 2016年 waninuser. All rights reserved.
//

import UIKit

class JDLayerAnimation{
    
    var animatedlayer:JDLayerClass!
    var timer:Timer!
    var BeatingLayer:JDInnerLayer!
    
    init(innerlayer:JDLayerClass) {
        animatedlayer = innerlayer
    }
    /*
        所有Layer點擊都會到這func
    */
    func LayerGrowning(progress:CGFloat)
    {
    
        if(timer != nil)
        {
            timer.invalidate()
        }
        if(progress == 0.0)
        {
            animatedlayer.resetToZeroPath()
            return
        }
        else if(progress != 0.0)
        {
            if let roundlayer = animatedlayer as? JDRoundLayer
            {
                let a:CABasicAnimation = CABasicAnimation(keyPath: "path")
                a.duration = 1.0
                a.fromValue = roundlayer.path!
                a.toValue = roundlayer.getPath(progress)
                roundlayer.add(a, forKey: "path")
                roundlayer.path = roundlayer.getPath(progress)
                return
            }
            //
            guard let InnerLayer = animatedlayer as? JDInnerLayer else {
                fatalError()
            }
            let a:CABasicAnimation = CABasicAnimation(keyPath: "path")
            a.duration = 1.0
            a.fromValue = animatedlayer.path!
            let path = InnerLayer.BezierPath.getPath(progress)
            a.toValue = path
            animatedlayer.add(a, forKey: "path")
            animatedlayer.path = path
            
            if(InnerLayer.IncreaseType == .water)
            {
                self.WaterLayerAnimation(percent: progress)
            }
            else if(InnerLayer.IncreaseType == .heartBeat && !InnerLayer.isBeatingLayer)
            {
                JDLayerAnimation(innerlayer: BeatingLayer).LayerGrowning(progress: progress * 1.1)
                self.HeartBeatAnimation(percent: progress)
            }
        }
        
    }
    
    
    func WaterLayerAnimation(percent:CGFloat)
    {
        let desiredLineWidth:CGFloat = 13
        animatedlayer.lineWidth = desiredLineWidth
    
        timer = Timer(timeInterval: 0.06, repeats: true, block:
        {_ in

            guard let InnerLayer = self.animatedlayer as? JDInnerLayer
                else{
                    fatalError()
                }
            OperationQueue.main.addOperation({
                let a:CABasicAnimation = CABasicAnimation(keyPath: "path")
                a.duration = 1.0
                a.fromValue = self.animatedlayer.path!
                let path = InnerLayer.BezierPath.getPath(percent)
                a.toValue = path
                self.animatedlayer.add(a, forKey: "path")
                self.animatedlayer.path = path
            })
        })
        RunLoop.main.add(timer!, forMode: .defaultRunLoopMode)
    }
    
    func HeartBeatAnimation(percent:CGFloat){
        
        guard let InnerLayer = animatedlayer as? JDInnerLayer,let beating = BeatingLayer else {
            fatalError()
        }
        timer = Timer(timeInterval: 1.5, repeats: true, block: {_ in
            
            let a:CABasicAnimation = CABasicAnimation(keyPath: "opacity")
            a.duration = 1.0
            a.fromValue = beating.opacity
            a.toValue = 0.5
            beating.add(a, forKey: "opacity")

            a.duration = 0.5
            a.fromValue = 0.5
            a.toValue = 0
            beating.add(a, forKey: "opacity")
        })
         RunLoop.main.add(timer!, forMode: .defaultRunLoopMode)
        
    }
    
   
    
}

class JDBezierPathClass{
    
    var IncreaseType:types = .downToTop
    var count:Int = 0 //for Water
    var halfsize:CGFloat!
    var originalRect:CGSize!
    
    init(type t:types,halfsize:CGFloat,originalRect:CGSize) {
        IncreaseType = t
        self.halfsize = halfsize
        self.originalRect = originalRect
    }
    
    
    func getPath(_ percent:CGFloat) -> CGPath{
        
        let desiredLineWidth:CGFloat = 13
        
        var r:CGFloat!
        var s:CGFloat!
        var e:CGFloat!
        var circlePath:UIBezierPath = UIBezierPath()
        
        if(IncreaseType == .downToTop)
        {
            r = CGFloat( halfsize - 2 * (desiredLineWidth/2) )
            s = CGFloat( CGFloat(Double.pi * 0.5) * (1 - percent/50))
            e = CGFloat( CGFloat(Double.pi * 0.5) * (1 + percent/50))
            
            circlePath = UIBezierPath(arcCenter: CGPoint(x:halfsize,y:halfsize),
                                      radius: r,
                                      startAngle: s,
                                      endAngle: e,
                                      clockwise: true)
            //circlePath.fill()
            return circlePath.cgPath
            
        }
        if(IncreaseType == .grownCircle )
        {
            r = CGFloat( (halfsize - 2 * (desiredLineWidth/2)) * percent/100.0 )
            s = CGFloat( 0 )
            e = CGFloat( CGFloat(Double.pi * 2) )
            
            circlePath = UIBezierPath(arcCenter: CGPoint(x:halfsize,y:halfsize),
                                      radius: r,
                                      startAngle: s,
                                      endAngle: e,
                                      clockwise: true)
            return circlePath.cgPath
        }
        if(IncreaseType == .water)
        {
            let centerY = halfsize * (100.0 - percent)/50
            let steps = 200                 // Divide the curve into steps
            let stepX = (2 * halfsize - 2 * (desiredLineWidth/2))/CGFloat(steps) // find the horizontal step distance
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 0, y: halfsize * 2 ))
            path.addLine(to: CGPoint(x: 0, y: centerY))
            
            for i in 0...steps {
                let x = CGFloat(i) * stepX
                let y = (sin(Double(i + self.count) * 0.04) * 8) + Double(centerY)
                path.addLine(to: CGPoint(x: x, y: CGFloat(y)))
            }
            path.addLine(to: CGPoint(x: 2 * halfsize, y: 2 * halfsize))
            path.close()
            
            if(self.count > 10000)
            {
                self.count = 0
            }
            self.count+=1
            return path.cgPath
        }
        if(IncreaseType == .heartBeat)
        {
            let scaledWidth = halfsize * 2 * (percent/100.0)
            let scaledXValue = halfsize * (1 - percent/100.0)
            let scaledHeight = halfsize * 2 * (percent/100.0)
            let scaledYValue = halfsize * (1 - percent/100.0) * 1.2
            
            let scaledRect = CGRect(x: scaledXValue, y: scaledYValue, width: scaledWidth, height: scaledHeight)
            circlePath.move(to: CGPoint(x: originalRect.width/2, y: scaledRect.origin.y + scaledRect.size.height))
            
            circlePath.addCurve(to: CGPoint(x: scaledRect.origin.x, y: scaledRect.origin.y + (scaledRect.size.height/4)),
                                controlPoint1:CGPoint(x:scaledRect.origin.x + (scaledRect.size.width/2), y:scaledRect.origin.y + (scaledRect.size.height*3/4)) ,
                                controlPoint2: CGPoint(x:scaledRect.origin.x,y: scaledRect.origin.y + (scaledRect.size.height/2)) )
            
            
            
            circlePath.addArc(withCenter: CGPoint(x:scaledRect.origin.x + (scaledRect.size.width/4),y:scaledRect.origin.y + (scaledRect.size.height/4)),
                              radius: (scaledRect.size.width/4),
                              startAngle: CGFloat(Double.pi),
                              endAngle: 0,
                              clockwise: true)
            
            circlePath.addArc(withCenter: CGPoint(x:scaledRect.origin.x + (scaledRect.size.width * 3/4),y:scaledRect.origin.y + (scaledRect.size.height/4)),
                              radius: (scaledRect.size.width/4),
                              startAngle: CGFloat(Double.pi),
                              endAngle: 0,
                              clockwise: true)
            
            circlePath.addCurve(to: CGPoint(x:originalRect.width/2,y: scaledRect.origin.y + scaledRect.size.height),
                                controlPoint1: CGPoint(x:scaledRect.origin.x + scaledRect.size.width,y: scaledRect.origin.y + (scaledRect.size.height/2)),
                                controlPoint2: CGPoint(x:scaledRect.origin.x + (scaledRect.size.width/2), y:scaledRect.origin.y + (scaledRect.size.height*3/4)) )
            circlePath.close()
            return circlePath.cgPath
        }
        
        
        r = CGFloat( halfsize - 2 * (desiredLineWidth/2) )
        s = CGFloat( CGFloat(Double.pi * 0.5) * (1 - percent/50))
        e = CGFloat( CGFloat(Double.pi * 0.5) * (1 + percent/50))
        
        circlePath = UIBezierPath(arcCenter: CGPoint(x:halfsize,y:halfsize),
                                  radius: r,
                                  startAngle: s,
                                  endAngle: e,
                                  clockwise: true)
        circlePath.fill()
        return circlePath.cgPath
    }
    
    
}

