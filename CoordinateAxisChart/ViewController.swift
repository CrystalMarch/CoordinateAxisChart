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
        for i in -50...50 {
            let xAxis = CGFloat(i)/10
            let yAxis = pow(2, xAxis) 
            /*
             yAxis = xAxis - 3 一次函数
             yAxis = pow(xAxis, 2)  幂函数
             yAxis = pow(2, xAxis) 指数函数
             yAxis = log (xAxis) 对数函数，此时应该设置i的值大于0
             yAxis = sin (xAxis) 三角函数 （sin cos tan）
             */
            pointData.append(CGPoint(x:xAxis,y:yAxis))
        }
        chartView.setPointData(pointData: pointData, chartType: .line)
        chartView.setPointData(pointData: [CGPoint(x:3,y:3)], chartType: .point)
        self.view.addSubview(chartView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

