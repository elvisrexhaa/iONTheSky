//
//  SelectedTabCustomShape.swift
//  DesginCodeWeatherApp
//
//  Created by Elvis Rexha on 10/05/2024.
//

import SwiftUI

struct SelectedTabCustomShape: Shape {
    func path(in rect: CGRect) -> Path {
            var path = Path()
            let width = rect.size.width
            let height = rect.size.height
            path.move(to: CGPoint(x: 0.42105*width, y: 0))
            path.addLine(to: CGPoint(x: 0.57895*width, y: 0))
            path.addCurve(to: CGPoint(x: 0.77343*width, y: 0.45091*height), control1: CGPoint(x: 0.69925*width, y: 0), control2: CGPoint(x: 0.73497*width, y: 0.22352*height))
            path.addCurve(to: CGPoint(x: 0.98496*width, y: 0.92593*height), control1: CGPoint(x: 0.81325*width, y: 0.68634*height), control2: CGPoint(x: 0.85338*width, y: 0.92593*height))
            path.addLine(to: CGPoint(x: 0.01504*width, y: 0.92593*height))
            path.addCurve(to: CGPoint(x: 0.22657*width, y: 0.45091*height), control1: CGPoint(x: 0.14662*width, y: 0.92593*height), control2: CGPoint(x: 0.18675*width, y: 0.68634*height))
            path.addCurve(to: CGPoint(x: 0.42105*width, y: 0), control1: CGPoint(x: 0.26503*width, y: 0.22352*height), control2: CGPoint(x: 0.30075*width, y: 0))
            path.closeSubpath()
            return path
        }
}

#Preview {
    SelectedTabCustomShape()
        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
}
