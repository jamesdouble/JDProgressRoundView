# JDProgressRoundView

兩種進度顯示方式 (types)： 
1  (.DownToTop) 

2   (.Loop)


3. (.GrownCircle)

4(.Water)



建構式： init(frame :CGRect)  —>   預設顯示方式(.DownToTop)     
JD:JDProgressRoundView = JDProgressRoundView(frame: self.JDView.frame)

init(frame :CGRect , t :types)  —> 指定顯示方式
JD = JDProgressRoundView(frame: self.JDView.frame, howtoincrease: .Loop)

 init (frame: CGRect,howtoincrease t:types,ProgressColor c:UIColor)  —> 指定進度顏色

Method:

setProgress(p:CGFloat, animated: Bool) —>  指定進度
setTypes(change:types) —> 切換顯示方式
