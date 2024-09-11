//
//  MainWeatherView.swift
//  DesginCodeWeatherApp
//
//  Created by Elvis Rexha on 11/05/2024.
//

import SwiftUI

struct MainWeatherView: View {
    @State private var text: String = ""
    @State private var showWeatherDetail: Bool = false
    @State private var selectedMockWeather: MockWeather? = nil
    @State private var animateWidgets: Bool = false
    @State private var selectedWeather: Weather? = nil
    
    @EnvironmentObject private var weatherViewModel: WeatherViewModel
    
    
    var filterWeatherResults: [Weather] {
        text.isEmpty ? weatherViewModel.weathers : weatherViewModel.weathers.filter({ $0.name.localizedStandardContains(text)})
        
    }
    
    var body: some View {
        ZStack {
            
            LinearGradient(colors: [.weatherForecastColor1, .weatherForecastColor2], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
            
            Circle()
                .frame(width: 200, height: 200)
                .foregroundStyle(.bgMainColor1)
                .blur(radius: 100)
                .offset(y: -340)
            
            Circle()
                .frame(width: 100, height: 100)
                .foregroundStyle(.bgMainColor1)
                .blur(radius: 100)
                .offset(x: 70 ,y: 240)
            
            
            
            VStack {
                header(text: $text, onSubmit: {
                    weatherViewModel.getWeather()
                    
                })
                
                ScrollView {
                    ForEach(Array(filterWeatherResults.enumerated()), id: \.offset) { index, weather in
                        weatherWidgetCell(weather: weather, onWeatherWidgetPressed: {
                            showWeatherDetail = true
                            selectedWeather = weather
                                
                            
                        })
                        .environmentObject(weatherViewModel)
                        .offset(y: animateWidgets ? 0 : UIScreen.main.bounds.height + 100)
                        .animation(.snappy(duration: 0.7).delay(Double(index) * 0.35), value: animateWidgets)
                    }
                    .padding(.bottom, 60)
                    .scrollTargetLayout()
                    .scrollTransition { content, phase in
                        content
                            .scaleEffect(phase.isIdentity ? 1 : 0.95)
                        
                    }
                }
                .animation(.smooth, value: text)
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.paging)
                
            }
        }
        .overlay {
            if let selectedWeather = selectedWeather, showWeatherDetail {
                WeatherDetailView(weather: selectedWeather, selectedWeather: $selectedWeather, showWeatherDetail: $showWeatherDetail)
                    .transition(.move(edge: .top).combined(with: .blurReplace))
                    .environmentObject(weatherViewModel)
            }
        }
        .onAppear {
            withAnimation(.smooth) {
                animateWidgets = true
            }
        }
    }
    
    @ViewBuilder
    private func header(text: Binding<String>, onSubmit: (() -> Void)?) -> some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color(.systemGray))
                .fontWeight(.medium)
            
            TextField(text: text) {
                Text("Search for city or airport")
                    .foregroundStyle(Color(.systemGray))
                    .fontWeight(.medium)
                
                
            }
            .foregroundStyle(.white)
            .onSubmit {
                withAnimation(.smooth) {
                    onSubmit?()
                }
            }
            
        }
        
        .padding(.leading, 6)
        
        .frame(width: UIScreen.main.bounds.width - 40, height: 36)
        .background(LinearGradient(colors: [.searchBarColor2, .searchBarColor2], startPoint: .topLeading, endPoint: .bottomTrailing), in: RoundedRectangle(cornerRadius: 10))
        
    }
    
    @ViewBuilder
    private func weatherWidgetCell(weather: Weather, onWeatherWidgetPressed: (() -> Void)?) -> some View {
        
        Button {
            withAnimation(.interactiveSpring(response: 0.4, dampingFraction: 0.8, blendDuration: 0.8)) {
                onWeatherWidgetPressed?()
            }
        } label: {
            ZStack(alignment: .bottom) {
                
                WeatherWidgetShape()
                    .frame(width: UIScreen.main.bounds.width - 40, height: 200)
                    .foregroundStyle(LinearGradient(colors: [.bgMainColor1, .bgMainColor2], startPoint: .leading, endPoint: .trailing))
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(formatString(argument: weather.main.temp))°")
                            .font(.system(size: 60))
                            .foregroundStyle(.white)
                            .bold()
                            .padding(.bottom, 20)
                    }
                    
                    HStack {
                        Text("H: \(formatString(argument: weather.main.tempMax))°")
                        
                        Text("L: \(formatString(argument: weather.main.tempMin))°")
                    }
                    .foregroundStyle(Color(.systemGray))
                    
                    HStack {
                        Text("\(weather.name)")
                            .frame(width: 250, alignment: .leading)
                            .foregroundStyle(.white)
                        
                    }
                }
                .padding(.bottom)
                .padding(.trailing, 60)
                
                
            }
            .overlay(alignment: .topTrailing) {
                Image(Weather.weatherImageByTemp(temp: weather.main.temp))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 160, height: 160)
            }
            .overlay(alignment: .bottomTrailing) {
                ForEach(weather.weather, id: \.id) { weather in
                    Text("\(weather.description.localizedCapitalized)")
                        .foregroundStyle(.white)
                        .padding()
                }
            }
        }
        .buttonStyle(ScaleButtonStyle())
        
        
    }
    
}

#Preview {
    MainWeatherView()
        .environmentObject(WeatherViewModel())
}


struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.89 : 1)
            .animation(.bouncy, value: configuration.isPressed)
    }
}




struct CustomWidgetShapeWithDrag: View {
    
    @State private var offset: CGSize = .zero
    let maxOffset: CGFloat = 50
    @State private var viewMore: Bool  = false
    
    
    var body: some View {
        ZStack {
            Group {
                WeatherWidgetShape()
                    .overlay(alignment: .leading) {
                        Text("View More")
                            .foregroundStyle(.white)
                            .bold()
                            .font(.title3)
                            .rotationEffect(.degrees(90))
                            .padding(.top)
                            .onTapGesture {
                                
                            }
                    }
                    .scaleEffect(viewMore ? 1 : 0.88)
                
                //
                WeatherWidgetShape()
                    .offset(offset)
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                let newOffset = CGSize(width: value.translation.width, height: value.translation.height)
                                
                                offset = CGSize(width: min(max(-maxOffset + 50, newOffset.width), maxOffset), height: 0)
                            })
                            .onEnded({ value in
                                withAnimation(.smooth) {
                                    if value.translation.width > 40 {
                                        offset = CGSize(width: maxOffset + 20 , height: 0)
                                        viewMore = true
                                    } else if value.translation.width > 0 || value.translation.width < 50 {
                                        withAnimation(.snappy) {
                                            offset = .zero
                                            viewMore = false
                                        }
                                    }
                                    
                                    
                                }
                            })
                        
                    )
                
                
                
            }
            .frame(width: UIScreen.main.bounds.width - 40, height: 200)
            .foregroundStyle(LinearGradient(colors: [.bgMainColor1, .bgMainColor2], startPoint: .leading, endPoint: .trailing))
        }
    }
}

#Preview {
    CustomWidgetShapeWithDrag()
}


extension View {
    func formatString(argument: Double) -> String {
        String(format: "%.0f", argument)
    }
}
