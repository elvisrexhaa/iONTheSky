//
//  ContentView.swift
//  DesginCodeWeatherApp
//
//  Created by Elvis Rexha on 10/05/2024.
//

import SwiftUI

struct WeatherDetailView: View {
    
    let weather: Weather
    @Binding var selectedWeather: Weather?
    @Binding var showWeatherDetail: Bool
    @State private var animateDetailView = false
    
    var body: some View {
        ZStack {
            background()
            
            ScrollView {
                
                scrollOffsetDetection(showWeatherDetail: $showWeatherDetail, selectedWeather: $selectedWeather)
                    
                
                VStack(spacing: 20) {
                    weatherData(weather: weather, animateDetailView: $animateDetailView)
                        .padding(.top, 20)

                    GeometryReader { geometry in
                        Image(.house)
                            .resizable()
                            .frame(width: geometry.size.width, height: geometry.size.height / 0.5)
                            .clipShape(.rect(cornerRadius: 20))
                            .offset(y: animateDetailView ? 0 : -1000)
                            .animation(.smooth.delay(0.7), value: animateDetailView)
                    }
                    .frame(height: 180)
                    
                    
                    ZStack (alignment: .top) {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(LinearGradient(colors: [.tabBarBgColor2, .tabBarBgColor1], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(height: 400)
                        //                            .padding(.top, 100)
                            .overlay {
                                VStack {
                                    Circle()
                                        .trim(from: 0, to: 0.5)
                                        .frame(width: 100, height: 100)
                                        .foregroundStyle(.indigo)
                                        .blur(radius: 35)
                                        .offset(y: -200)
                                    
                                }
                                
                            }
                        
                        VStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 60, height: 4)
                                .padding(.top, 10)
                                .foregroundStyle(.customShapeColor2)
                            
                            
                            HStack {
                                Text("Hourly Forecast")
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                                
                                
                                
                                Text("Weekly Forecast")
                            }
                            .padding(.horizontal)
                            .foregroundStyle(.white.opacity(0.4))
                            .fontWeight(.semibold)
                            .font(.subheadline)
                            
                            Rectangle()
                                .frame(width: UIScreen.main.bounds.width, height: 2)
                                .foregroundStyle(.white.opacity(0.1))
                                .shadow(radius: 2)
                            
                            ScrollView(.horizontal) {
                                HStack(spacing: 16) {
                                    ForEach(0...10, id: \.self) { index in
                                        weatherForecastCapsule(index: index)
                                        
                                    }
                                }
                                
                                .padding(.top, 6)
                                .padding(.leading)
                            }
                            .scrollIndicators(.hidden)
                            
                            
                            
                        }
                        
                        
                    }
                    .padding(.top, 100)
                    .offset(y: animateDetailView ? 0 : -1000)
                    .animation(.smooth.delay(0.9), value: animateDetailView)
 
                }
                
            }
            
            
            
        }
        .onAppear {
            withAnimation(.smooth) {
                animateDetailView = true
            }
        }
        .overlay(alignment: .topLeading) {
            Button {
                withAnimation(.smooth) {
                    selectedWeather = nil
                    showWeatherDetail = false
                }
            } label: {
                Image(systemName: "chevron.left")
                    .bold()
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(Color.customShapeColor2, in: Circle())
                    .padding()
            }
        }
    }
    
    @ViewBuilder
    private func background() -> some View {
        ZStack(alignment: .bottom) {
            Image(.bg)
                .resizable()
                .ignoresSafeArea()
            
            
            LinearGradient(colors: [.gradient1.opacity(0.012),.gradient1.opacity(0.6), .gradient1, .gradient1, .gradient1], startPoint: .top, endPoint: .bottom)
                .frame(width: UIScreen.main.bounds.width, height: 500)
                .ignoresSafeArea()
            
            
        }
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    private func weatherData(weather: Weather, animateDetailView: Binding<Bool>) -> some View {
        VStack {
            Text(weather.name)
                .foregroundStyle(.white)
                .font(.title2)
                .fontWeight(.semibold)
                .offset(y: animateDetailView.wrappedValue ? 0 : -200)
                .animation(.smooth.delay(0.2), value: animateDetailView.wrappedValue)
            
            Text("\(formatString(argument: weather.main.temp))°")
                .fontWeight(.regular)
                .font(.system(size: 60))
                .foregroundStyle(.white)
                .offset(y: animateDetailView.wrappedValue ? 0 : -200)
                .animation(.smooth.delay(0.5), value: animateDetailView.wrappedValue)
            
            
            VStack {
                ForEach(weather.weather, id: \.id) { weather in
                    Text("\(weather.description)")
                        .foregroundStyle(Color(.systemGray2))
                        .offset(y: animateDetailView.wrappedValue ? 0 : -300)
                        .animation(.smooth.delay(0.7), value: animateDetailView.wrappedValue)
                }
                    
                
                HStack {
                    Text("H: \(formatString(argument: weather.main.tempMax))°")
                    Text("L: \(formatString(argument: weather.main.tempMin))°")
                }
                .foregroundStyle(.white)
                .fontWeight(.medium)
                .offset(y: animateDetailView.wrappedValue ? 0 : -300)
                .animation(.smooth.delay(0.7), value: animateDetailView.wrappedValue)
            }
        }
        .multilineTextAlignment(.center)
    }
    
    
    @ViewBuilder
    private func weatherForecastCapsule(index: Int) -> some View {
        Capsule()
            .frame(width: 60, height: 146)
            .foregroundStyle(.weatherForecastCapsule.opacity(0.4))
            .shadow(radius: 20)
            .overlay(content: {
                Capsule()
                    .stroke(lineWidth: 0.12)
                    .foregroundStyle(.white)
            })
            .overlay {
                VStack {
                    Text("12 AM")
                    
                    Image((index % 2 == 0) ? .thunder : (index % 4 == 0) ? .sun : .moonCloudStars)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                    
                    Text("19°")
                }
                .foregroundStyle(.white).bold()
            }
    }
}

//#Preview {
//    WeatherDetailView(weather: MockWeather.mockWeatherData()[0], selectedWeather: .constant(MockWeather.mockWeatherData()[1]), showWeatherDetail: .constant(false))
//}




struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
    
}

extension View {
    func scrollOffsetDetection(showWeatherDetail: Binding<Bool>, selectedWeather: Binding<Weather?>) -> some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .global).minY)
        }
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
            withAnimation(.smooth) {
                if value > 140 {
                    showWeatherDetail.wrappedValue = false
                    selectedWeather.wrappedValue = nil
                }
            }
        }
    }
}

