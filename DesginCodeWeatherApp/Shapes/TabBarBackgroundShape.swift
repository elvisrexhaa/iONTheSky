//
//  TabBarBackgroundShape.swift
//  DesginCodeWeatherApp
//
//  Created by Elvis Rexha on 10/05/2024.
//

import SwiftUI

struct TabBarBackgroundShape: Shape {
    
    
        func path(in rect: CGRect) -> Path {
            var path = Path()
            let width = rect.size.width
            let height = rect.size.height
            path.move(to: CGPoint(x: 0, y: 0))
            path.addCurve(to: CGPoint(x: 0.32564*width, y: 0.22727*height), control1: CGPoint(x: 0, y: 0), control2: CGPoint(x: 0.19507*width, y: 0.18162*height))
            path.addCurve(to: CGPoint(x: 0.5*width, y: 0.26136*height), control1: CGPoint(x: 0.39318*width, y: 0.25089*height), control2: CGPoint(x: 0.43219*width, y: 0.26136*height))
            path.addCurve(to: CGPoint(x: 0.67179*width, y: 0.22727*height), control1: CGPoint(x: 0.56781*width, y: 0.26136*height), control2: CGPoint(x: 0.60426*width, y: 0.25089*height))
            path.addCurve(to: CGPoint(x: width, y: 0), control1: CGPoint(x: 0.80237*width, y: 0.18162*height), control2: CGPoint(x: width, y: 0))
            path.addLine(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: 0, y: height))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.closeSubpath()
            return path
        }

}

#Preview(body: {
    TabBarBackgroundShape()
        .frame(width: UIScreen.main.bounds.width - 40, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
        .foregroundStyle (
            LinearGradient(colors: [.gradient1.opacity(0.3)], startPoint: .leading, endPoint: .trailing)
        )
        
        
})





