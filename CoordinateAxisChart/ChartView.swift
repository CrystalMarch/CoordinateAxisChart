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
        let xAxis = UIView()
        let yAxis = UIView()
        var width :CGFloat!
        var height :CGFloat!
    var lineArray :[CGPoint]!
    let backgroundView = UIView()
    let xMargin = CGFloat(14)
    let yMargin = CGFloat(14)
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        } 
    }
    func updateLayerFrames() {
        self.layer.masksToBounds = true
        width = self.frame.width - 2*xMargin
        height = self.frame.height - 2*yMargin
        if width > 0 {
           
            backgroundView.frame = self.bounds
            self.addSubview(backgroundView)
            self.addAxis()
            self.addArrowForAxis()
        }
       
    }
    
    func addAxis() {
        xAxis.frame = CGRect(x:0,y:height/2+yMargin,width:self.frame.width,height:0.5)
        xAxis.backgroundColor = UIColor.black
        yAxis.frame = CGRect(x:width/2+xMargin,y:0,width:0.5,height:self.frame.height)
        yAxis.backgroundColor = UIColor.black
        backgroundView.addSubview(xAxis)
        backgroundView.addSubview(yAxis)
        for i in -5...5 {
            let xLine = UIView()
            xLine.backgroundColor = UIColor.black
            xLine.frame = CGRect(x:CGFloat(i)*width/10 + width/2 + xMargin,y:height/2-height/40+yMargin,width:0.5,height:height/20)
            backgroundView.addSubview(xLine)
            let yLine = UIView()
            yLine.backgroundColor = UIColor.black
            yLine.frame = CGRect(x:width/2-width/40+xMargin,y:height/2 - CGFloat(i)*height/10 + yMargin,width:width/20,height:0.5)
            backgroundView.addSubview(yLine)
            let xLabel = UILabel()
            xLabel.font = UIFont.systemFont(ofSize: 10)
            xLabel.text = "\(i)"
            if i != 0 {
                xLabel.textAlignment = .center
            }else{
                xLabel.textAlignment = .right
            }
            xLabel.frame = CGRect(x:CGFloat(i)*width/10 + width/2 - width/20 + xMargin,y:height/2+height/40+yMargin,width:width/10,height:height/20)
            backgroundView.addSubview(xLabel)
            let yLabel = UILabel()
            yLabel.frame = CGRect(x:width/2+width/40+xMargin,y:height/2 - CGFloat(i)*height/10 - height/20 + yMargin,width:width/10,height:height/10)
            yLabel.font = UIFont.systemFont(ofSize: 10)
            yLabel.textAlignment = .center
            if i != 0  {
                yLabel.text = "\(i)"
            }
            backgroundView.addSubview(yLabel)
        }
       
    }
    func addArrowForAxis() {
        let path = UIBezierPath()
        let yLayer = CAShapeLayer()
        let xLayer = CAShapeLayer()
        
        path.move(to: CGPoint(x:backgroundView.frame.size.width/2-5,y:5))
        path.addLine(to: CGPoint(x:backgroundView.frame.size.width/2,y:0))
        path.addLine(to: CGPoint(x:backgroundView.frame.size.width/2+5,y:5))
        yLayer.path = path.cgPath
        yLayer.fillColor = UIColor.clear.cgColor
        yLayer.strokeColor = UIColor.black.cgColor
        yLayer.lineWidth = 0.5
        backgroundView.layer.addSublayer(yLayer)
        path.move(to: CGPoint(x:backgroundView.frame.size.width-5,y:backgroundView.frame.size.height/2-5))
        path.addLine(to: CGPoint(x:backgroundView.frame.size.width,y:backgroundView.frame.size.height/2))
        path.addLine(to: CGPoint(x:backgroundView.frame.size.width-5,y:backgroundView.frame.size.height/2+5))
        xLayer.path = path.cgPath
        xLayer.fillColor = UIColor.clear.cgColor
        xLayer.strokeColor = UIColor.black.cgColor
        xLayer.lineWidth = 0.5
        backgroundView.layer.addSublayer(xLayer)
        
    }
    func setPointData(pointData:[CGPoint],chartType:ChartType) {
        lineArray = pointData
        if chartType == .line {
            self.addLine()
        }else{
            self.addPoint()
        }
    }
    func addPoint()  {
        let pointWidth = CGFloat(4)
        let pointHeight = CGFloat(4)
        
        let firstPoint = lineArray.first!
        let startPoint = CGPoint(x:firstPoint.x*width/10 + width/2 + xMargin - pointWidth/2,y:height/2 - firstPoint.y*height/10 + yMargin - pointHeight/2)
        let layer = CALayer()
        layer.frame = CGRect(x:startPoint.x, y:startPoint.y, width:pointWidth, height:pointHeight)
        layer.backgroundColor = UIColor.red.cgColor
        backgroundView.layer.addSublayer(layer)
    }
    func addLine(){

        let firstPoint = lineArray.first!
        let startPoint = CGPoint(x:firstPoint.x*width/10 + width/2+xMargin,y:height/2 - firstPoint.y*height/10 + yMargin)
        let path = UIBezierPath()
        let layer = CAShapeLayer()
        
        path.move(to: startPoint)
        for i in 0...lineArray.count - 2 {
            if i != 0 {
                let endPoint = lineArray[i + 1]
                let controlPoint = lineArray[i]
                
                path.addQuadCurve(to: CGPoint(x:endPoint.x*width/10 + width/2 + xMargin,y:height/2 - endPoint.y*height/10 + yMargin), controlPoint: CGPoint(x:controlPoint.x*width/10 + width/2 + xMargin,y:height/2 - controlPoint.y*height/10 + yMargin))
            }
        }
       
        
        layer.path = path.cgPath
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.red.cgColor
        
        backgroundView.layer.addSublayer(layer)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
