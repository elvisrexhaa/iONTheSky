//
//  CustomTabBar.swift
//  DesginCodeWeatherApp
//
//  Created by Elvis Rexha on 10/05/2024.
//

import SwiftUI

enum Tab: String, CaseIterable {
    
    case location = "location"
    case add = "plus"
    case filter = "line.3.horizontal.decrease"
    
}


struct CustomTabBar: View {
    
    @Binding var activeTab: Tab
    @Binding var showSheet: Bool
    
    var body: some View {
        HStack {
            ForEach(Array(Tab.allCases.enumerated()), id: \.element) { index, tab in
            
                Button {
                    withAnimation(.smooth) {
                        if index != 1 {
                            activeTab = tab
                        }
                    }
                } label: {
                    ZStack {
                        if index == 1 {
                            CustomAddButton {
                                //show sheet -> boolean value for this...
                                showSheet = true
                            }
                        } else {
                            Image(systemName: tab.rawValue)
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        }
                    }
                    .padding(.bottom, index == 1 ? 24 : 0)
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 90)

        .background(
            ZStack {
                TabBarBackgroundShape()
                    .foregroundStyle (
                        LinearGradient(colors: [.tabBarBgColor1.opacity(0.4), .tabBarBgColor2], startPoint: .top, endPoint: .bottom))
                    .frame(height: 100)
            }
        
        )
        
    }
}

#Preview {
    CustomTabBar(activeTab: .constant(.add), showSheet: .constant(false))
}


struct CustomAddButton: View {
    
    var onAddPressed: (() -> Void)?
    
    var body: some View {
        ZStack {
            SelectedTabCustomShape()
                .frame(width: 210, height: 110)
                .padding(.top, 30)
                .foregroundStyle(LinearGradient(colors: [.customShapeColor2, .customShapeColor1], startPoint: .top, endPoint: .bottom))
                .overlay {
                    Button {
                        onAddPressed?()
                    } label: {
                        Circle()
                            .frame(width: 60, height: 60)
                            .foregroundStyle(Color(.systemGray).opacity(0.2))
                            .shadow(radius: 5)
                            .blur(radius: 1)
                            .overlay {
                                Circle()
                                    .foregroundStyle(.white)
                                    .padding(3)
                                    .shadow(radius: 10, y: 2)
                            }
                    }
                    
                    Image(systemName: "plus")
                        .foregroundStyle(.gradient1)
                        .fontWeight(.heavy)
                        .font(.title3)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                }
        }
    }
}

#Preview {
    ViewThatFits {
        CustomAddButton()
    }
        
}
