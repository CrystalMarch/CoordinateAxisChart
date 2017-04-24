# CoordinateAxisChart
## Drawing graphs of point, linear function, power function, exponential function, logarithmic function, circular function, etc in a coordinate. （实现了在坐标系中画点，一次函数，幂函数，指数函数，对数函数，三角函数等）

### for instance:
* linear function(一次函数): yAxis = xAxis - 3 
* power function(幂函数): yAxis = pow(xAxis, 2) 
* exponential function(指数函数): yAxis = pow(2, xAxis) 
* logarithmic function, xAxis should be greater than zero(对数函数, 此时应该设置axis的值大于0): yAxis = log (xAxis) 
* circular function(三角函数), like sin, cos, tan: yAxis = sin (xAxis) 

### Android version entrance
> [CoordinateAxisChart for Android](https://github.com/KiBa1215/CoordinateAxisChart)
## Installation

### CocoaPods

Add to your Podfile:

Swift 3.0:
```ruby
use_frameworks!
pod 'CoordinateAxisChart', '~> 0.0.5'
```
Note: To use Swift 3.x / master, you need Xcode 8+

To use master directly (it's usually stable):
```ruby
pod 'CoordinateAxisChart', :git => 'https://github.com/CrystalMarch/CoordinateAxisChart.git'
```

And then:
```ruby
pod install
```

Import the framework in your code:
```swift
import CoordinateAxisChart
```

## Quick start 

```swift
let chartView = CoordinateAxisChart()
        chartView.frame = CGRect(x:50,y:50,width:220,height:220)
        var pointData: [CGPoint] = []
        for i in -40...70 {
            let xAxis = CGFloat(i)/10
            let yAxis = sin (xAxis)
            pointData.append(CGPoint(x:xAxis,y:yAxis))
        }
        chartView.setPointData(pointData: pointData, chartType: .line,lineOrPointColor:UIColor .red,animation: true)
        chartView.xMaxValue = 7
        chartView.animationTime = 2
        chartView.axisColor = UIColor.gray
        chartView.xMinValue = -4
        chartView.yMaxValue = 3
        chartView.yMinValue = -3
        self.view.addSubview(chartView)
```
### Properties:
#### xMaxValue:
* set the max value of x axis(设置x轴的最大值)
#### xMinValue:
* set the min value of x axis(设置x轴的最小值)
#### yMaxValue:
* set the max value of y axis(设置y轴的最大值)
#### yMinValue:
* set the min value of y axis(设置y轴的最小值)
#### axisColor:
* set the color of the axis(设置坐标轴的颜色)
#### animationTime:
* set the animation time of draw line(设置画函数线条的动画时间)

### Function:
#### setPointData(pointData:[CGPoint],chartType:ChartType,lineOrPointColor:UIColor,animation:Bool)
* pointDate: set the data for chart
* chartType: set the chart type (line or point)
* lineOrPointColor: set the line or point color
* animation: set whether animation is needed 

![alt text](https://github.com/CrystalMarch/CoordinateAxisChart/blob/master/charttwo.png)
![alt text](https://github.com/CrystalMarch/CoordinateAxisChart/blob/master/chart.png)

