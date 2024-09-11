//
//  WeatherWidgetShape.swift
//  DesginCodeWeatherApp
//
//  Created by Elvis Rexha on 11/05/2024.
//

import SwiftUI

struct WeatherWidgetShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0, y: 0.41319*height))
        path.addCurve(to: CGPoint(x: 0.03312*width, y: 0.08238*height), control1: CGPoint(x: 0, y: 0.22511*height), control2: CGPoint(x: 0, y: 0.13107*height))
        path.addCurve(to: CGPoint(x: 0.21492*width, y: 0.09718*height), control1: CGPoint(x: 0.06623*width, y: 0.03369*height), control2: CGPoint(x: 0.1158*width, y: 0.05485*height))
        path.addLine(to: CGPoint(x: 0.9003*width, y: 0.38986*height))
        path.addCurve(to: CGPoint(x: 0.98602*width, y: 0.45299*height), control1: CGPoint(x: 0.94813*width, y: 0.41028*height), control2: CGPoint(x: 0.97204*width, y: 0.42049*height))
        path.addCurve(to: CGPoint(x: width, y: 0.62159*height), control1: CGPoint(x: width, y: 0.48549*height), control2: CGPoint(x: width, y: 0.53086*height))
        path.addLine(to: CGPoint(x: width, y: 0.76216*height))
        path.addCurve(to: CGPoint(x: 0.98116*width, y: 0.96517*height), control1: CGPoint(x: width, y: 0.87428*height), control2: CGPoint(x: width, y: 0.93034*height))
        path.addCurve(to: CGPoint(x: 0.87135*width, y: height), control1: CGPoint(x: 0.96232*width, y: height), control2: CGPoint(x: 0.93199*width, y: height))
        path.addLine(to: CGPoint(x: 0.12865*width, y: height))
        path.addCurve(to: CGPoint(x: 0.01884*width, y: 0.96517*height), control1: CGPoint(x: 0.06801*width, y: height), control2: CGPoint(x: 0.03768*width, y: height))
        path.addCurve(to: CGPoint(x: 0, y: 0.76216*height), control1: CGPoint(x: 0, y: 0.93034*height), control2: CGPoint(x: 0, y: 0.87428*height))
        path.addLine(to: CGPoint(x: 0, y: 0.41319*height))
        path.closeSubpath()
        return path
    }
    
}

#Preview {
    WeatherWidgetShape()
        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
}
