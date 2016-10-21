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
    
    init(innerlayer:JDInnerLayer) {
        animatedlayer = innerlayer
    }
    
    
     func WaterLayerAnimation(FillingColor c:UIColor,percent:CGFloat){
        
        let desiredLineWidth:CGFloat = 13
        animatedlayer.lineWidth = desiredLineWidth
        
        timer = Timer(timeInterval: 0.1, repeats: true, block: {_ in
   
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

    
    
}
