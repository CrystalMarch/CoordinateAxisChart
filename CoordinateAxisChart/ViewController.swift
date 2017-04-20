//
//  ViewController.swift
//  CoordinateAxisChart
//
//  Created by 朱慧平 on 2017/4/13.
//  Copyright © 2017年 朱慧平. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let chartView = ChartView()
        chartView.frame = CGRect(x:50,y:50,width:220,height:220)
        var pointData: [CGPoint] = []
        for i in -40...70 {
            let xAxis = CGFloat(i)/10
            let yAxis = tan (xAxis)
            /*
             yAxis = xAxis - 3 linear function(一次函数)
             yAxis = pow(xAxis, 2) - 1 power function(幂函数)
             yAxis = pow(2, xAxis) exponential function(指数函数)
             yAxis = log (xAxis) logarithmic function, xAxis should be greater than zero(对数函数, 此时应该设置xAxis的值大于0)
             yAxis = sin (xAxis) circular function(三角函数),
             */
            pointData.append(CGPoint(x:xAxis,y:yAxis))
        }
        chartView.setPointData(pointData: pointData, chartType: .line,lineOrPointColor:UIColor .red)
        chartView.setPointData(pointData: [CGPoint(x:-2,y:1)], chartType: .point,lineOrPointColor:UIColor .black)
        chartView.xMaxValue = 7
        chartView.axisColor = UIColor.gray
        chartView.xMinValue = -4
        chartView.yMaxValue = 5
        chartView.yMinValue = -5
        self.view.addSubview(chartView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

