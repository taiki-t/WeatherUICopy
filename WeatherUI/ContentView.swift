//
//  ContentView.swift
//  WeatherUI
//
//  Created by 高山泰基 on 2023/01/28.
//

import SwiftUI

struct ScrollPrerefenceKey: PreferenceKey {
    typealias Value = Anchor<CGPoint>?
    
    static var defaultValue: Value = nil
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

struct ContentView: View {
//    let headerMaxHeight: CGFloat = 300
    let headerMinHeight: CGFloat = 100
    let componentHeight: CGFloat = 200
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(height: headerMinHeight)
                .opacity(0)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 10) {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.blue.opacity(0.0))
                        .frame(height: componentHeight)
                        .anchorPreference(key: ScrollPrerefenceKey.self, value: .top, transform: {$0} )
                    
                    ForEach(0..<6) {_ in
                        WeatherInfoComponentView()
                    }
                }
            }
            .coordinateSpace(name: "infoList")
            .padding(.horizontal)
        }
        .background(Image("13EA09B8-20D6-475A-BD4A-CFC6631F12A1"))
        .overlayPreferenceValue(ScrollPrerefenceKey.self) { preference in
            GeometryReader { geometry in
                preference.map { anchor in
                    ZStack {
                        VStack {
                            Text("\(geometry[anchor].y)")
                            Text("東京都")
                                .font(.title)
                            Text("5° 曇り時々晴れ")
                                .fontWeight(.bold)
                                .opacity(geometry[anchor].y < -40 ? (-(geometry[anchor].y + 40) / 60.0) : 0)
                            Text("3°")
                                .font(.system(size: 80))
                                .fontWeight(.light)
                                .opacity(geometry[anchor].y < 20 ? (geometry[anchor].y + 40) / 60.0 : 1.0)
                            Text("やや曇り")
                                .fontWeight(.bold)
                                .opacity(geometry[anchor].y < 50 ? (geometry[anchor].y - 20) / 30.0 : 1.0)
                            Text("最高:5° 最低:-2°")
                                .fontWeight(.bold)
                                .opacity(geometry[anchor].y < 70 ? (geometry[anchor].y - 50) / 20.0 : 1.0)
                            Spacer()
                        }
                    }
                    .foregroundColor(.white)
                    .shadow(radius: 6)
                    .frame(
                        width: geometry.size.width
                    )
                    .offset(y: max((geometry[anchor].y + 100) / componentHeight * 50, 0))
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
