//
//  MainTabBarView.swift
//  DesginCodeWeatherApp
//
//  Created by Elvis Rexha on 10/05/2024.
//

import SwiftUI

struct MainTabBarView: View {
    
    @State private var activeTab: Tab = .location
    @State private var showSheet: Bool = false
    
    @StateObject private var weatherViewModel = WeatherViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $activeTab) {
                
                MainWeatherView()
                    .tabItem { /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Item Label@*/Text("Label")/*@END_MENU_TOKEN@*/ }
                    .tag(Tab.location)
                    .environmentObject(weatherViewModel)
                
                Text("Home")
                    .tabItem { /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Item Label@*/Text("Label")/*@END_MENU_TOKEN@*/ }
                    .tag(Tab.add)
                
                Text("Home")
                    .tabItem { /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Item Label@*/Text("Label")/*@END_MENU_TOKEN@*/ }
                    .tag(Tab.filter)
            }
            
            CustomTabBar(activeTab: $activeTab, showSheet: $showSheet)
                
        }
        .sheet(isPresented: $showSheet, content: {
            AddWeatherView()
                .presentationDetents([.medium])
                .environmentObject(weatherViewModel)
        })
        .ignoresSafeArea()
        .onAppear {
            UITabBar.appearance().isHidden = true
        }
    }
}

#Preview {
    MainTabBarView()
        .environmentObject(WeatherViewModel())
}
