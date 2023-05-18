//
//  WeatherInfoComponentView.swift
//  WeatherUI
//
//  Created by 高山泰基 on 2023/02/27.
//

import SwiftUI

struct WeatherInfoComponentView: View {
    let componentHeight: CGFloat = 200
    
    var body: some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("infoList")).minY
            VStack(spacing: 0) {
                ZStack(alignment: .topLeading) {
                    VStack(alignment: .leading) {
                        Text(minY.description)
                        Divider()
                    }
                    .opacity(minY < 0 ? (5 + minY) / 5.0 : 1)
                    
                    VStack(alignment: .leading) {
                        Text("天気の説明")
                            .fontWeight(.bold)
                            .opacity(0.7)
                            
                    }
                    .opacity(minY < -5 ? (1.0 - (10 + minY) / 10.0) : 0)
                }
                .padding(.leading)
                .frame(height: 50)
                .background(.ultraThinMaterial.opacity(minY < -150 ? 1 : 0))
                .cornerRadius(15)
                .offset(y: minY < 0 ? max(-minY, -150) : 0)
                
                VStack {
                    Text("icons")
                    Text("icons")
                    Text("icons")
                    Text(proxy.frame(in: .global).size.height.description)
                }
                .padding()
                .frame(height: 150)
                .mask(alignment: .bottom) {
                    Rectangle()
                        .frame(height: minY < 0 ? max(150 + minY, 0) : 150)
                }
            }
            .background(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 15)
                .fill(.ultraThinMaterial.opacity(minY >= -150 ? 1 : 0))
                .frame(height: minY < 0 ? max(componentHeight + minY, 0) : componentHeight)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .colorScheme(.dark)
            .opacity(minY >= -150 ? 1 : (componentHeight + minY) / 50.0)
        }
        .frame(height: componentHeight)
    }
}

struct WeatherInfoComponentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherInfoComponentView()
    }
}
