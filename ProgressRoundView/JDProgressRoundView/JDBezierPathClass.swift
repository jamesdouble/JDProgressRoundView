//
//  JDBezierPathClass.swift
//  ProgressRoundView
//
//  Created by waninuser on 2016/10/21.
//  Copyright © 2016年 waninuser. All rights reserved.
//

import UIKit

class JDBezierPathClass{
    
   static func getPath(_ percent:CGFloat,innerlayer :JDInnerLayer,originalRect:CGRect) -> CGPath{
        
        let desiredLineWidth:CGFloat = 13
   
        var r:CGFloat!
        var s:CGFloat!
        var e:CGFloat!
        var circlePath:UIBezierPath = UIBezierPath()
        
        if(innerlayer.ParentInnerView?.IncreaseType == .downToTop)
        {
            r = CGFloat( innerlayer.halfSize - 2 * (desiredLineWidth/2) )
            s = CGFloat( CGFloat(Double.pi * 0.5) * (1 - percent/50))
            e = CGFloat( CGFloat(Double.pi * 0.5) * (1 + percent/50))
            
            circlePath = UIBezierPath(arcCenter: CGPoint(x:innerlayer.halfSize,y:innerlayer.halfSize),
                                      radius: r,
                                      startAngle: s,
                                      endAngle: e,
                                      clockwise: true)
            circlePath.fill()
            return circlePath.cgPath
            
        }
        if(innerlayer.ParentInnerView?.IncreaseType == .grownCircle )
        {
            r = CGFloat( (innerlayer.halfSize - 2 * (desiredLineWidth/2)) * percent/100.0 )
            s = CGFloat( 0 )
            e = CGFloat( CGFloat(Double.pi * 2) )
            
            circlePath = UIBezierPath(arcCenter: CGPoint(x:innerlayer.halfSize,y:innerlayer.halfSize),
                                      radius: r,
                                      startAngle: s,
                                      endAngle: e,
                                      clockwise: true)
            circlePath.fill()
            return circlePath.cgPath
        }
        if(innerlayer.ParentInnerView?.IncreaseType == .water)
        {
            let centerY = innerlayer.halfSize * (100.0 - percent)/50
            let steps = 200                 // Divide the curve into steps
            let stepX = (2 * innerlayer.halfSize - 2 * (desiredLineWidth/2))/CGFloat(steps) // find the horizontal step distance
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 0, y: innerlayer.halfSize * 2 ))
            path.addLine(to: CGPoint(x: 0, y: centerY))
            
            for i in 0...steps {
                let x = CGFloat(i) * stepX
                var y = 0.0
                if(innerlayer.layeranimation != nil)
                {
                    y = (sin(Double(i + (innerlayer.layeranimation?.count)!) * 0.04) * 8) + Double(centerY)
                }
                else{
                    y = (sin(Double(i) * 0.04) * 8) + Double(centerY)
                }
                path.addLine(to: CGPoint(x: x, y: CGFloat(y)))
            }
            path.addLine(to: CGPoint(x: 2 * innerlayer.halfSize, y: 2 * innerlayer.halfSize))
            path.close()
            let fillColor = UIColor.blue
            fillColor.setFill()
            path.fill()
            return path.cgPath
        }
        if(innerlayer.ParentInnerView?.IncreaseType == .heartBeat)
        {
            let scaledWidth = innerlayer.halfSize * 2 * (percent/100.0)
            let scaledXValue = innerlayer.halfSize * (1 - percent/100.0)
            let scaledHeight = innerlayer.halfSize * 2 * (percent/100.0)
            let scaledYValue = innerlayer.halfSize * (1 - percent/100.0) * 1.2
            
            let scaledRect = CGRect(x: scaledXValue, y: scaledYValue, width: scaledWidth, height: scaledHeight)
            circlePath.move(to: CGPoint(x: originalRect.size.width/2, y: scaledRect.origin.y + scaledRect.size.height))
        
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
            
            circlePath.addCurve(to: CGPoint(x:originalRect.size.width/2,y: scaledRect.origin.y + scaledRect.size.height),
                                controlPoint1: CGPoint(x:scaledRect.origin.x + scaledRect.size.width,y: scaledRect.origin.y + (scaledRect.size.height/2)),
                                controlPoint2: CGPoint(x:scaledRect.origin.x + (scaledRect.size.width/2), y:scaledRect.origin.y + (scaledRect.size.height*3/4)) )
            circlePath.close()
            return circlePath.cgPath
        }
        
        
        r = CGFloat( innerlayer.halfSize - 2 * (desiredLineWidth/2) )
        s = CGFloat( CGFloat(Double.pi * 0.5) * (1 - percent/50))
        e = CGFloat( CGFloat(Double.pi * 0.5) * (1 + percent/50))
        
        circlePath = UIBezierPath(arcCenter: CGPoint(x:innerlayer.halfSize,y:innerlayer.halfSize),
                                  radius: r,
                                  startAngle: s,
                                  endAngle: e,
                                  clockwise: true)
        circlePath.fill()
        return circlePath.cgPath
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
    
}
