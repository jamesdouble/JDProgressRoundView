//
//  JDLayerAnimation.swift
//  ProgressRoundView
//
//  Created by waninuser on 2016/10/21.
//  Copyright © 2016年 waninuser. All rights reserved.
//

import UIKit

class JDLayerAnimation{
    
    var animatedlayer:JDInnerLayer!
    var timer:Timer!
    var count:Int = 0
    var BeatingLayer:JDInnerLayer?
    
    init(innerlayer:JDInnerLayer) {
        animatedlayer = innerlayer
    }
    
    
     func WaterLayerAnimation(FillingColor c:UIColor,percent:CGFloat){
        let desiredLineWidth:CGFloat = 13
        animatedlayer.lineWidth = desiredLineWidth
        
        timer = Timer(timeInterval: 0.06, repeats: true, block: {_ in
    
            let centerY = self.animatedlayer.halfSize * (100.0 - percent)/50
            let steps = 200                 // Divide the curve into steps
            let stepX = (2 * self.animatedlayer.halfSize - 2 * (desiredLineWidth/2))/CGFloat(steps) // find the horizontal step distance
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 0, y: self.animatedlayer.halfSize * 2 ))
            path.addLine(to: CGPoint(x: 0, y: centerY))
            for i in 0...steps {
                let x = CGFloat(i) * stepX
                let y = (sin(Double(i + self.count) * 0.04) * 8) + Double(centerY)
                path.addLine(to: CGPoint(x: x, y: CGFloat(y)))
            }
            path.addLine(to: CGPoint(x: 2 * self.animatedlayer.halfSize, y: 2 * self.animatedlayer.halfSize))
            path.close()
            let fillColor = UIColor.blue
            fillColor.setFill()
            path.fill()
            if(self.count > 10000)
            {
             self.count = 0
            }
            self.count+=1
            OperationQueue.main.addOperation({
                let a:CABasicAnimation = CABasicAnimation(keyPath: "path")
                a.duration = 1.0
                a.fromValue = self.animatedlayer.path!
                a.toValue = path.cgPath
                self.animatedlayer.add(a, forKey: "path")
                self.animatedlayer.path = path.cgPath
            })
            
            self.animatedlayer.fillColor = c.cgColor
            self.animatedlayer.strokeColor = UIColor.clear.cgColor
            self.animatedlayer.lineWidth = desiredLineWidth
        })
        
        RunLoop.main.add(timer!, forMode: .defaultRunLoopMode)
        
    }
    
    func HeartBeatAnimation(FillingColor c:UIColor,percent:CGFloat){
        
        if(BeatingLayer?.superlayer == nil)
        {
        BeatingLayer = JDInnerLayer(ParentControll: self.animatedlayer.ParentInnerView!)
        BeatingLayer?.opacity = 0.0
        BeatingLayer?.HeartShadow = true
        BeatingLayer?.DrawCircle(theBounds: (self.animatedlayer.ParentInnerView?.bounds)!, FillingColor: UIColor.red, percent: percent * 1.2)
        self.animatedlayer.ParentInnerView?.layer.addSublayer(BeatingLayer!)
        return
        }
        else if(percent == 0.0){
        JDLayerAnimation.LayerGrowning(ProgressInnerLayer: BeatingLayer!, progress: percent * 1.1)
        return
        }
        JDLayerAnimation.LayerGrowning(ProgressInnerLayer: BeatingLayer!, progress: percent * 1.1)
        
        timer = Timer(timeInterval: 1.5, repeats: true, block: {_ in
            let a:CABasicAnimation = CABasicAnimation(keyPath: "opacity")
            a.duration = 1.0
            a.fromValue = self.BeatingLayer?.opacity
            a.toValue = 0.5
            self.BeatingLayer?.add(a, forKey: "opacity")

            a.duration = 0.5
            a.fromValue = 0.5
            a.toValue = 0
            self.BeatingLayer?.add(a, forKey: "opacity")
        })
        
         RunLoop.main.add(timer!, forMode: .defaultRunLoopMode)
        
    }
    
    static func LayerGrowning(ProgressInnerLayer p:JDInnerLayer,progress:CGFloat){
        if(p.layeranimation?.timer != nil)
        {
        p.layeranimation?.timer.invalidate()
        }
        if(p.ParentInnerView?.progress != 0.0)
        {
                let a:CABasicAnimation = CABasicAnimation(keyPath: "path")
                a.duration = 1.0
                a.fromValue = p.path!
                a.toValue = JDBezierPathClass.getPath(percent: progress, innerlayer: p, originalRect: (p.ParentInnerView?.frame)!)
                p.add(a, forKey: "path")
                p.path = JDBezierPathClass.getPath(percent: progress, innerlayer: p, originalRect: (p.ParentInnerView?.frame)!)
        }
        else{
                p.removeAllAnimations()
                p.path = JDBezierPathClass.getPath(percent: 0.0, innerlayer: p, originalRect:  (p.ParentInnerView?.frame)!)
        }
        if(p.ParentInnerView?.IncreaseType == .Water || p.ParentInnerView?.IncreaseType == .HeartBeat)
        {
          p.tickAnimation(FillingColor: (p.ParentInnerView?.bgColor)!, percent: progress)
        }
    }
    
    
}
