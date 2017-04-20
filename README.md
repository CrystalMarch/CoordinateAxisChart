# CoordinateAxisChart
## Drawing graphs of point, linear function, power function, exponential function, logarithmic function, circular function, etc in a coordinate. （实现了在坐标系中画点，一次函数，幂函数，指数函数，对数函数，三角函数等）

### for instance:
* linear function(一次函数): yAxis = xAxis - 3 
* power function(幂函数): yAxis = pow(xAxis, 2) 
* exponential function(指数函数): yAxis = pow(2, xAxis) 
* logarithmic function, xAxis should be greater than zero(对数函数, 此时应该设置axis的值大于0): yAxis = log (xAxis) 
* circular function(三角函数), like sin, cos, tan: yAxis = sin (xAxis) 

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

