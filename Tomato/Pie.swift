//
//  Pie.swift
//  Memorizer
//
//  Created by Антон Нехаев on 28.08.2022.
//

import SwiftUI

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

struct Curve: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockWise = false
    
    func path(in rect: CGRect) -> Path {
        let centre = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
//        let start = CGPoint(
//            x: centre.x + radius * CGFloat(cos(startAngle.radians)),
//            y: centre.y + radius * CGFloat(sin(startAngle.radians))
//        )
//        let end = CGPoint(
//            x: centre.x + radius * CGFloat(cos(endAngle.radians)),
//            y: centre.y + radius * CGFloat(sin(endAngle.radians))
//        )
//        let size: CGFloat = 30.0
        var p = Path()
        if endAngle.degrees == 270 {
            return p
        }
        if endAngle == startAngle {
            p.addEllipse(in: rect)
        }
        else {
            p.addArc(center: centre,
                     radius: radius,
                     startAngle: endAngle,
                     endAngle: startAngle,
                     clockwise: clockWise)
        }
//        print("Angle", startAngle.degrees, endAngle.degrees)
        return p
    }
    
}

struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockWise = false
    
    func path(in rect: CGRect) -> Path {
        let centre = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
//        let start = CGPoint(
//            x: centre.x + radius * CGFloat(cos(startAngle.radians)),
//            y: centre.y + radius * CGFloat(sin(startAngle.radians))
//        )
//        let end = CGPoint(
//            x: centre.x + radius * CGFloat(cos(endAngle.radians)),
//            y: centre.y + radius * CGFloat(sin(endAngle.radians))
//        )
//        let size: CGFloat = 30.0
        var p = Path()
       
        
        p.addArc(center: centre,
                 radius: radius - 3,
                 startAngle: endAngle,
                 endAngle: startAngle,
                 clockwise: clockWise)
        p.addArc(center: centre,
                 radius: radius + 2,
                 startAngle: startAngle,
                 endAngle: endAngle,
                 clockwise: !clockWise)
        return p
    }
    
    
}
