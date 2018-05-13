//
//  ChartView.swift
//  Chart
//
//  Created by 朱慧平 on 2017/4/5.
//  Copyright © 2017年 朱慧平. All rights reserved.
//

import UIKit
public enum ChartType {
    case point
    case line
}
open class CoordinateAxisChart: UIView {
    fileprivate let xAxis = UIView()
    fileprivate let yAxis = UIView()
    fileprivate var width :CGFloat!
    fileprivate var height :CGFloat!
    fileprivate var pointArray = Array<[CGPoint]>()
    fileprivate var chartTypeArray = Array<ChartType>()
    fileprivate var lineColorArray = Array<UIColor>()
    fileprivate var layerArray = Array<CALayer>()
    fileprivate var animationArray = Array<Bool>()
    fileprivate let backgroundView = UIView()
    fileprivate let yArrowLayer = CAShapeLayer()
    fileprivate let xArrowLayer = CAShapeLayer()
    fileprivate var xMargin = CGFloat(14)
    fileprivate var yMargin = CGFloat(14)

    public var xMaxValue:Int = 5 {
        didSet {
            updateLayerFrames()
        }
    }

   public var yMaxValue:Int = 5 {
        didSet {
            updateLayerFrames()
        }
    }

   public var xMinValue:Int = -5 {
        didSet {
            updateLayerFrames()
        }
    }

   public var yMinValue:Int = -5 {
        didSet {
            updateLayerFrames()
        }
    }

    public var axisColor: UIColor = .black {
        didSet {
            updateLayerFrames()
        }

    }

    public var animationTime: Float = 1 {
        didSet {
            updateLayerFrames()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    override open var frame: CGRect {
        didSet {
            updateLayerFrames()
        } 
    }

   fileprivate func updateLayerFrames() {
        self.layer.masksToBounds = true
        
        xMargin = self.frame.width/CGFloat(2+xMaxValue-xMinValue)
        yMargin = self.frame.width/CGFloat(2+yMaxValue-yMinValue)
        width = self.frame.width - 2*xMargin
        height = self.frame.height - 2*yMargin
        if width > 0 {
            backgroundView.removeFromSuperview()
            for subview in backgroundView.subviews {
                subview.removeFromSuperview()
            }
            backgroundView.layer.removeFromSuperlayer()
            backgroundView.frame = self.bounds
            self.addSubview(backgroundView)
            self.addAxis()
            self.addArrowForAxis()
            self.reSetPointData()
        }
       
    }
   fileprivate func addAxis() {
        xAxis.frame = CGRect(x:0,y:CGFloat(yMaxValue + 1)*yMargin,width:self.frame.width,height:0.5)
        yAxis.frame = CGRect(x:CGFloat(1-xMinValue)*xMargin,y:0,width:0.5,height:self.frame.height)
        xAxis.backgroundColor = axisColor
        yAxis.backgroundColor = axisColor
        backgroundView.addSubview(xAxis)
        backgroundView.addSubview(yAxis)
        for xIndex in xMinValue...xMaxValue{
            let xLine = UIView()
            xLine.backgroundColor = axisColor
            xLine.frame = CGRect(x:CGFloat(xIndex-xMinValue+1)*xMargin,y:(CGFloat(yMaxValue + 1)-0.25)*yMargin,width:0.5,height:yMargin/2)
            backgroundView.addSubview(xLine)
            let xLabel = UILabel()
            xLabel.textColor = axisColor
            xLabel.font = UIFont.systemFont(ofSize: 10)
            xLabel.text = "\(xIndex)"
            if xIndex != 0 {
                xLabel.textAlignment = .center
            }else{
                xLabel.textAlignment = .right
            }
            xLabel.frame = CGRect(x:(CGFloat(xIndex-xMinValue+1)-0.5)*xMargin,y:(CGFloat(yMaxValue + 1)+0.25)*yMargin,width:xMargin,height:yMargin/2)
            backgroundView.addSubview(xLabel)
        }
        
        for yIndex in yMinValue...yMaxValue {
            
            let yLine = UIView()
            yLine.backgroundColor = axisColor
            yLine.frame = CGRect(x:(CGFloat(1-xMinValue)-0.25)*xMargin,y:CGFloat(yMaxValue-yIndex+1)*yMargin,width:xMargin/2,height:0.5)
            backgroundView.addSubview(yLine)
            
            let yLabel = UILabel()
            yLabel.textColor = axisColor
            yLabel.frame = CGRect(x:(CGFloat(1-xMinValue)+0.25)*xMargin,y:(CGFloat(yMaxValue-yIndex+1)-0.5)*yMargin,width:xMargin,height:yMargin)
            yLabel.font = UIFont.systemFont(ofSize: 10)
            yLabel.textAlignment = .center
            if yIndex != 0  {
                yLabel.text = "\(yIndex)"
            }
            backgroundView.addSubview(yLabel)
        }
    }
   fileprivate func addArrowForAxis() {
        xArrowLayer.removeFromSuperlayer()
        yArrowLayer.removeFromSuperlayer()
        let path = UIBezierPath()
        path.move(to: CGPoint(x:CGFloat(1-xMinValue)*xMargin-5,y:5))
        path.addLine(to: CGPoint(x:CGFloat(1-xMinValue)*xMargin,y:0))
        path.addLine(to: CGPoint(x:CGFloat(1-xMinValue)*xMargin+5,y:5))
        yArrowLayer.path = path.cgPath
        yArrowLayer.fillColor = UIColor.clear.cgColor
        yArrowLayer.strokeColor = axisColor.cgColor
        yArrowLayer.lineWidth = 0.5
        backgroundView.layer.addSublayer(yArrowLayer)
        path.move(to: CGPoint(x:backgroundView.frame.size.width-5,y:CGFloat(yMaxValue + 1)*yMargin-5))
        path.addLine(to: CGPoint(x:backgroundView.frame.size.width,y:CGFloat(yMaxValue + 1)*yMargin))
        path.addLine(to: CGPoint(x:backgroundView.frame.size.width-5,y:CGFloat(yMaxValue + 1)*yMargin+5))
        xArrowLayer.path = path.cgPath
        xArrowLayer.fillColor = UIColor.clear.cgColor
        xArrowLayer.strokeColor = axisColor.cgColor
        xArrowLayer.lineWidth = 0.5
        backgroundView.layer.addSublayer(xArrowLayer)
        
    }
    public func clear(){
        for subLayer in layerArray {
            subLayer.removeFromSuperlayer()
        }
        layerArray.removeAll()
    }
    public func refresh(){
        self.reSetPointData()
    }
   public func setPointData(pointData:[CGPoint],chartType:ChartType,lineOrPointColor:UIColor,animation:Bool) {
        pointArray.append(pointData)
        lineColorArray.append(lineOrPointColor)
        chartTypeArray.append(chartType)
        animationArray.append(animation)
        if chartType == .line {
            self.addLine(pointData: pointData,lineColor: lineOrPointColor,animation: animation)
        }else{
            self.addPoint(pointData: pointData,pointColor: lineOrPointColor)
        }
    }
    fileprivate  func reSetPointData() {
        for subLayer in layerArray {
            subLayer.removeFromSuperlayer()
        }
        layerArray.removeAll()
        for index in 0..<chartTypeArray.count {
            let indexPoints = pointArray[index]
            let indexChartType = chartTypeArray[index]
            let indexLineColor = lineColorArray[index]
            let indexAnimation = animationArray[index]
            
            if indexChartType == .line {
                self.addLine(pointData: indexPoints,lineColor: indexLineColor,animation: indexAnimation)
            }else{
                self.addPoint(pointData: indexPoints,pointColor: indexLineColor)
            }
        }
    }
    fileprivate func addPoint(pointData:[CGPoint],pointColor:UIColor)  {
        let pointWidth = CGFloat(4)
        let pointHeight = CGFloat(4)
        
        let firstPoint = pointData.first!
        let startPoint = CGPoint(x:(firstPoint.x+CGFloat(1-xMinValue))*xMargin-pointWidth/2,y:(CGFloat(yMaxValue+1)-firstPoint.y)*yMargin-pointHeight/2)
        let layer = CALayer()
        layer.frame = CGRect(x:startPoint.x, y:startPoint.y, width:pointWidth, height:pointHeight)
        layer.backgroundColor = pointColor.cgColor
        backgroundView.layer.addSublayer(layer)
        layerArray.append(layer)
    }
    fileprivate func addLine(pointData:[CGPoint],lineColor:UIColor,animation:Bool){

        let firstPoint = pointData.first!
        let startPoint = CGPoint(x:(firstPoint.x+CGFloat(1-xMinValue))*xMargin,y:(CGFloat(yMaxValue+1)-firstPoint.y)*yMargin)
        let path = UIBezierPath()
        let layer = CAShapeLayer()
        
        path.move(to: startPoint)
        for i in 0...pointData.count - 2 {
            if i != 0 {
                let endPoint = pointData[i + 1]
                let controlPoint = pointData[i]
                
                path.addQuadCurve(to: CGPoint(x:(endPoint.x+CGFloat(1-xMinValue))*xMargin,y:(CGFloat(yMaxValue+1)-endPoint.y)*yMargin), controlPoint: CGPoint(x:(controlPoint.x+CGFloat(1-xMinValue))*xMargin,y:(CGFloat(yMaxValue+1)-controlPoint.y)*yMargin))
            }
        }
        layer.path = path.cgPath
        if animation {
            let animation = CABasicAnimation()
            animation.keyPath = "strokeEnd"
            animation.duration = CFTimeInterval(animationTime)
            animation.toValue = 1
            animation.fromValue = 0
            animation.autoreverses = false
            animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
            layer.add(animation, forKey: "stroke")
        }
        
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = lineColor.cgColor
        backgroundView.layer.addSublayer(layer)
        layerArray.append(layer)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
