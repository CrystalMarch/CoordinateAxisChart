//
//  ChartView.swift
//  Chart
//
//  Created by 朱慧平 on 2017/4/5.
//  Copyright © 2017年 朱慧平. All rights reserved.
//

import UIKit
enum ChartType {
    case point
    case line
}
class ChartView: UIView {
    fileprivate let xAxis = UIView()
    fileprivate let yAxis = UIView()
    fileprivate var width :CGFloat!
    fileprivate var height :CGFloat!
    fileprivate var point = Array<[CGPoint]>()
    fileprivate var chartType = Array<ChartType>()
    fileprivate var lineColor = Array<UIColor>()
    fileprivate var layerArray = Array<CALayer>()
    fileprivate let backgroundView = UIView()
    fileprivate let yArrowLayer = CAShapeLayer()
    fileprivate let xArrowLayer = CAShapeLayer()
    fileprivate var xMargin = CGFloat(14)
    fileprivate var yMargin = CGFloat(14)
    fileprivate var _xMarginMaxValue:Int = 5
    var xMarginMaxValue:Int {
        get{
            return _xMarginMaxValue
        }
        set{
          _xMarginMaxValue = newValue
            updateLayerFrames()
            
        }
    }
   fileprivate var _yMarginMaxValue:Int = 5
    var yMarginMaxValue:Int {
        get{
            return _yMarginMaxValue
        }
        set{
            _yMarginMaxValue = newValue
            updateLayerFrames()
        }
    }
   fileprivate var _xMarginMinValue:Int = -5
    var xMarginMinValue:Int {
        get{
           return _xMarginMinValue
        }
        set{
            _xMarginMinValue = newValue
            updateLayerFrames()
        }
    }
   fileprivate var _yMarginMinValue:Int = -5
    var yMarginMinValue:Int {
        get{
            return _yMarginMinValue
        }
        set{
            _yMarginMinValue = newValue
            updateLayerFrames()
        }
    }
    fileprivate var _axisColor :UIColor = UIColor.black
    var axisColor:UIColor{
        get{
            return _axisColor
        }
        set{
            _axisColor = newValue
            updateLayerFrames()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        } 
    }
   fileprivate func updateLayerFrames() {
        self.layer.masksToBounds = true
        
        xMargin = self.frame.width/CGFloat(2+xMarginMaxValue-xMarginMinValue)
        yMargin = self.frame.width/CGFloat(2+yMarginMaxValue-yMarginMinValue)
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
        xAxis.frame = CGRect(x:0,y:CGFloat(yMarginMaxValue + 1)*yMargin,width:self.frame.width,height:0.5)
        yAxis.frame = CGRect(x:CGFloat(1-xMarginMinValue)*xMargin,y:0,width:0.5,height:self.frame.height)
        xAxis.backgroundColor = _axisColor
        yAxis.backgroundColor = _axisColor
        backgroundView.addSubview(xAxis)
        backgroundView.addSubview(yAxis)
        for xIndex in xMarginMinValue...xMarginMaxValue{
            let xLine = UIView()
            xLine.backgroundColor = _axisColor
            xLine.frame = CGRect(x:CGFloat(xIndex-xMarginMinValue+1)*xMargin,y:(CGFloat(yMarginMaxValue + 1)-0.25)*yMargin,width:0.5,height:height/20)
            backgroundView.addSubview(xLine)
            let xLabel = UILabel()
            xLabel.textColor = _axisColor
            xLabel.font = UIFont.systemFont(ofSize: 10)
            xLabel.text = "\(xIndex)"
            if xIndex != 0 {
                xLabel.textAlignment = .center
            }else{
                xLabel.textAlignment = .right
            }
            xLabel.frame = CGRect(x:(CGFloat(xIndex-xMarginMinValue+1)-0.5)*xMargin,y:(CGFloat(yMarginMaxValue + 1)+0.25)*yMargin,width:xMargin,height:yMargin/2)
            backgroundView.addSubview(xLabel)
        }
        
        for yIndex in yMarginMinValue...yMarginMaxValue {
            
            let yLine = UIView()
            yLine.backgroundColor = _axisColor
            yLine.frame = CGRect(x:(CGFloat(1-xMarginMinValue)-0.25)*xMargin,y:CGFloat(yMarginMaxValue-yIndex+1)*yMargin,width:xMargin/2,height:0.5)
            backgroundView.addSubview(yLine)
            
            let yLabel = UILabel()
            yLabel.textColor = _axisColor
            yLabel.frame = CGRect(x:(CGFloat(1-xMarginMinValue)+0.25)*xMargin,y:(CGFloat(yMarginMaxValue-yIndex+1)-0.5)*yMargin,width:xMargin,height:yMargin)
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
        path.move(to: CGPoint(x:CGFloat(1-xMarginMinValue)*xMargin-5,y:5))
        path.addLine(to: CGPoint(x:CGFloat(1-xMarginMinValue)*xMargin,y:0))
        path.addLine(to: CGPoint(x:CGFloat(1-xMarginMinValue)*xMargin+5,y:5))
        yArrowLayer.path = path.cgPath
        yArrowLayer.fillColor = UIColor.clear.cgColor
        yArrowLayer.strokeColor = _axisColor.cgColor
        yArrowLayer.lineWidth = 0.5
        backgroundView.layer.addSublayer(yArrowLayer)
        path.move(to: CGPoint(x:backgroundView.frame.size.width-5,y:CGFloat(yMarginMaxValue + 1)*yMargin-5))
        path.addLine(to: CGPoint(x:backgroundView.frame.size.width,y:CGFloat(yMarginMaxValue + 1)*yMargin))
        path.addLine(to: CGPoint(x:backgroundView.frame.size.width-5,y:CGFloat(yMarginMaxValue + 1)*yMargin+5))
        xArrowLayer.path = path.cgPath
        xArrowLayer.fillColor = UIColor.clear.cgColor
        xArrowLayer.strokeColor = _axisColor.cgColor
        xArrowLayer.lineWidth = 0.5
        backgroundView.layer.addSublayer(xArrowLayer)
        
    }
    func setPointData(pointData:[CGPoint],chartType:ChartType,lineOrPointColor:UIColor) {
        point.append(pointData)
        lineColor.append(lineOrPointColor)
        self.chartType.append(chartType)
        if chartType == .line {
            self.addLine(pointData: pointData,lineColor: lineOrPointColor)
        }else{
            self.addPoint(pointData: pointData,pointColor: lineOrPointColor)
        }
    }
    fileprivate  func reSetPointData() {
        for subLayer in layerArray {
            subLayer.removeFromSuperlayer()
        }
        layerArray.removeAll()
        for index in 0..<chartType.count {
            let indexPoints = point[index]
            let indexChartType = chartType[index]
            let indexLineColor = lineColor[index]
            if indexChartType == .line {
                self.addLine(pointData: indexPoints,lineColor: indexLineColor)
            }else{
                self.addPoint(pointData: indexPoints,pointColor: indexLineColor)
            }
        }
    }
    fileprivate func addPoint(pointData:[CGPoint],pointColor:UIColor)  {
        let pointWidth = CGFloat(4)
        let pointHeight = CGFloat(4)
        
        let firstPoint = pointData.first!
        let startPoint = CGPoint(x:(firstPoint.x+CGFloat(1-xMarginMinValue))*xMargin-pointWidth/2,y:(CGFloat(yMarginMaxValue+1)-firstPoint.y)*yMargin-pointHeight/2)
        let layer = CALayer()
        layer.frame = CGRect(x:startPoint.x, y:startPoint.y, width:pointWidth, height:pointHeight)
        layer.backgroundColor = pointColor.cgColor
        backgroundView.layer.addSublayer(layer)
        layerArray.append(layer)
    }
    fileprivate func addLine(pointData:[CGPoint],lineColor:UIColor){

        let firstPoint = pointData.first!
        let startPoint = CGPoint(x:(firstPoint.x+CGFloat(1-xMarginMinValue))*xMargin,y:(CGFloat(yMarginMaxValue+1)-firstPoint.y)*yMargin)
        let path = UIBezierPath()
        let layer = CAShapeLayer()
        
        path.move(to: startPoint)
        for i in 0...pointData.count - 2 {
            if i != 0 {
                let endPoint = pointData[i + 1]
                let controlPoint = pointData[i]
                
                path.addQuadCurve(to: CGPoint(x:(endPoint.x+CGFloat(1-xMarginMinValue))*xMargin,y:(CGFloat(yMarginMaxValue+1)-endPoint.y)*yMargin), controlPoint: CGPoint(x:(controlPoint.x+CGFloat(1-xMarginMinValue))*xMargin,y:(CGFloat(yMarginMaxValue+1)-controlPoint.y)*yMargin))
            }
        }
        layer.path = path.cgPath
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = lineColor.cgColor
        backgroundView.layer.addSublayer(layer)
        layerArray.append(layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
