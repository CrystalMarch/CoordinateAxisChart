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

    final class RefreshButton: UIButton {
        convenience init(viewController: ViewController) {
            self.init()
            frame = CGRect(x:30,y:40,width:120,height:30)
            setTitle("refresh", for: .normal)
            addTarget(self, action: #selector(viewController.refreshButonClick), for: .touchUpInside)
            setTitleColor(.gray, for: .normal)
            setTitleColor(.red, for: .highlighted)
            layer.borderWidth = 1
            layer.borderColor = UIColor.gray.cgColor
        }
    }

    final class ClearButton: UIButton {
        convenience init(viewController: ViewController) {
            self.init()
            frame = CGRect(x: viewController.view.frame.size.width-150, y: 40, width: 120, height: 30)
            setTitle("clear", for: .normal)
            addTarget(self, action: #selector(viewController.clearButtonClick), for: .touchUpInside)
            setTitleColor(.gray, for: .normal)
            setTitleColor(.red, for: .highlighted)
            layer.borderWidth = 1
            layer.borderColor = UIColor.gray.cgColor
        }
    }

    final class ChangeAxisValueButton: UIButton {
        convenience init(viewController: ViewController) {
            self.init()
            frame = CGRect(x:30,y:80,width: viewController.view.frame.size.width - 60,height:30)
            setTitle("change coordinate axis value", for: .normal)
            addTarget(self, action: #selector(viewController.changeAxisValueButtonClick), for: .touchUpInside)
            setTitleColor(.gray, for: .normal)
            setTitleColor(.red, for: .highlighted)
            layer.borderWidth = 1
            layer.borderColor = UIColor.gray.cgColor
        }
    }

    final class ChangeAxisColorButton: UIButton {
        convenience init(viewController: ViewController) {
            self.init()
            frame = CGRect(x:30,y:120,width: viewController.view.frame.size.width - 60,height:30)
            setTitle("change coordinate axis color", for: .normal)
            addTarget(self, action: #selector(viewController.changeAxisColorButtonClick), for: .touchUpInside)
            setTitleColor(.gray, for: .normal)
            setTitleColor(.red, for: .highlighted)
            layer.borderWidth = 1
            layer.borderColor = UIColor.gray.cgColor
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let refreshButton = RefreshButton(viewController: self)
        self.view.addSubview(refreshButton)

        let clearButton = ClearButton(viewController: self)
        self.view.addSubview(clearButton)

        let changeAxisValueButton = ChangeAxisValueButton(viewController: self)
        self.view.addSubview(changeAxisValueButton)

        let changeAxisColorButton = ChangeAxisColorButton(viewController: self)
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

