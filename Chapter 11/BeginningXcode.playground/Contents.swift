//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var sum = 4
for i in 0 ..< 6 {
    sum += sum * i
}
sum


var bounds = CGRect(x: 0,y: 0,width: 200,height: 200)
var center = CGPoint(x: 100, y: 100)
var radius = CGFloat(100.0)

var path:UIBezierPath = UIBezierPath()
path.addArc(withCenter: center,
            radius: radius,
            startAngle: CGFloat(0),
            endAngle: (CGFloat(M_PI) * 2),
            clockwise: true)
path.stroke()

