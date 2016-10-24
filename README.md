# JDProgressRoundView

###Mutiple Display Style (types)：

`1  (.DownToTop)` ` 2   (.Loop)` `3. (.GrownCircle)`  

![Alt text](/../master/readme_img/DownToTop.png?raw=true "DownToTop") ![Alt text](/../master/readme_img/Loop.png?raw=true "DownToTop") ![Alt text](/../master/readme_img/GrownCircle.png?raw=true "DownToTop") 


 ` 4(.Water)` `5(.HeartBeat)`

![Alt text](/../master/readme_img/water.gif?raw=true "DownToTop") ![Alt text](/../master/readme_img/HeartBeat.gif?raw=true "HeartBeat.gif")

***
#Introduction

JDProgressRoundView is Stylish Process Meter Based on UIProgressView.
It growns 5% every tap, or you can just set the progress u want.

Thanks for using.

***
#Usage

`init(frame :CGRect)`  —>  Default: types=(.DownToTop)  color=(red)   
Example
JD:JDProgressRoundView = JDProgressRoundView(frame: self.view.frame)

---

`init(frame: CGRect,howtoincrease t:types,unit u:String)`  —> Default: color=(red)
Example
JD = JDProgressRoundView(frame: self.view.frame, howtoincrease: .Loop,unit: "%")

---
`init (frame: CGRect,howtoincrease t:types,ProgressColor c:UIColor,BorderWidth b:CGFloat)` 
Example
JD = JDProgressRoundView(frame: self.view.frame, howtoincrease: .Water,ProgressColor:UIColor.blue,BorderWidth:13.0)


###Method:

setProgress(p:CGFloat, animated: Bool) —>  SetProgress Directly(Default maximun = 100.0)

setTypes(change:types) —> Change Display Style above
