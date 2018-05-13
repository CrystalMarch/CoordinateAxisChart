//
//  ViewController.swift
//  CoordinateAxisChart
//
//  Created by 朱慧平 on 2017/4/13.
//  Copyright © 2017年 朱慧平. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let chartView = CoordinateAxisChart()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let refreshButton = UIButton()
        refreshButton.frame = CGRect(x:30,y:40,width:120,height:30)
        refreshButton.setTitle("refresh", for: .normal)
        refreshButton.addTarget(self, action: #selector(self.refreshButonClick(sender:)), for: .touchUpInside)
        refreshButton.setTitleColor(.gray, for: .normal)
        refreshButton.setTitleColor(.red, for: .highlighted)
        refreshButton.layer.borderWidth = 1
        refreshButton.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(refreshButton)
        let clearButton =  UIButton()
        clearButton.frame = CGRect(x:self.view.frame.size.width-150,y:40,width:120,height:30)
        clearButton.setTitle("clear", for: .normal)
        clearButton.addTarget(self, action: #selector(self.clearButtonClick(sender:)), for: .touchUpInside)
        clearButton.setTitleColor(.gray, for: .normal)
        clearButton.setTitleColor(.red, for: .highlighted)
        clearButton.layer.borderWidth = 1
        clearButton.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(clearButton)
        let changeAxisValueButton =  UIButton()
        changeAxisValueButton.frame = CGRect(x:30,y:80,width:self.view.frame.size.width - 60,height:30)
        changeAxisValueButton.setTitle("change coordinate axis value", for: .normal)
        changeAxisValueButton.addTarget(self, action: #selector(self.changeAxisValueButtonClick(sender:)), for: .touchUpInside)
        changeAxisValueButton.setTitleColor(.gray, for: .normal)
        changeAxisValueButton.setTitleColor(.red, for: .highlighted)
        changeAxisValueButton.layer.borderWidth = 1
        changeAxisValueButton.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(changeAxisValueButton)

        let changeAxisColorButton =  UIButton()
        changeAxisColorButton.frame = CGRect(x:30,y:120,width:self.view.frame.size.width - 60,height:30)
        changeAxisColorButton.setTitle("change coordinate axis color", for: .normal)
        changeAxisColorButton.addTarget(self, action: #selector(self.changeAxisColorButtonClick(sender:)), for: .touchUpInside)
        changeAxisColorButton.setTitleColor(.gray, for: .normal)
        changeAxisColorButton.setTitleColor(.red, for: .highlighted)
        changeAxisColorButton.layer.borderWidth = 1
        changeAxisColorButton.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(changeAxisColorButton)

        chartView.frame = CGRect(x:50,y:170,width:220,height:220)
        let pointData: [CGPoint] = (-40...70).map {
            let xAxis = CGFloat($0)/10
            let yAxis = sin (xAxis)
            /*
             yAxis = xAxis - 3 linear function(一次函数)
             yAxis = pow(xAxis, 2) - 1 power function(幂函数)
             yAxis = pow(2, xAxis) exponential function(指数函数)
             yAxis = log (xAxis) logarithmic function, xAxis should be greater than zero(对数函数, 此时应该设置xAxis的值大于0)
             yAxis = sin (xAxis) circular function(三角函数),
             */
            return CGPoint(x: xAxis, y: yAxis)
        }

        chartView.setPointData(pointData: pointData, chartType: .line, lineOrPointColor: .red, animation: true)
//        chartView.setPointData(pointData: [CGPoint(x:-2,y:1)], chartType: .point,lineOrPointColor:UIColor .black,animation: false)
        chartView.xMaxValue = 7
        chartView.animationTime = 2
        chartView.axisColor = .gray
        chartView.xMinValue = -4
        chartView.yMaxValue = 3
        chartView.yMinValue = -3
        self.view.addSubview(chartView)
    }
    func refreshButonClick(sender:UIButton) {
        chartView.refresh()
    }
    func clearButtonClick(sender:UIButton) {
        chartView.clear()
    }
    func changeAxisColorButtonClick(sender: UIButton) {
        chartView.axisColor = .random()
    }
    func changeAxisValueButtonClick(sender:UIButton) {
        chartView.xMaxValue = Int(arc4random()%10)
        chartView.xMinValue = -Int(arc4random()%10)
        chartView.yMaxValue = Int(arc4random()%10)
        chartView.yMinValue = -Int(arc4random()%10)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension UIColor {
    static func random() -> UIColor {
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

