//
//  AddWeatherView.swift
//  DesginCodeWeatherApp
//
//  Created by Elvis Rexha on 14/05/2024.
//

import SwiftUI

struct AddWeatherView: View {
    
    
    @EnvironmentObject private var weatherViewModel: WeatherViewModel
    
    var body: some View {
        ZStack {
            Color.tabBarBgColor2.ignoresSafeArea()
            
            
            VStack {
                Text("Add Weather Below")
                    .foregroundStyle(.white)
                    .bold()
                    .font(.lowercaseSmallCaps(Font.title)())
                
                TextField(text: $weatherViewModel.city) {
                    Text("Search for weather to add")
                        .foregroundStyle(Color(.systemGray))
                        .font(.callout)
                        .bold()
                }
                .foregroundStyle(.white)
                .padding()
                .background(.customShapeColor2, in: RoundedRectangle(cornerRadius: 8))
                .padding(.horizontal)
                
                
                Button {
                    weatherViewModel.getWeather()
//                    weatherViewModel.addWeatherToList()
                   
                } label: {
                    Text("Add")
                        .foregroundStyle(.white)
                        .padding()
                        .frame(width: UIScreen.main.bounds.width - 240)
                        .background(.bgMainColor1, in: RoundedRectangle(cornerRadius: 8))
                       
                }
                .padding(.top, 20)
                
                if let weather = weatherViewModel.weather {
                    Text(weather.name)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .bold()
                        .padding(.top, 30)
                }

            }
            

        }
    }
}

#Preview {
    AddWeatherView()
        .environmentObject(WeatherViewModel())
}
