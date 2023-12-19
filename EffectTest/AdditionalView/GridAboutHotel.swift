//
//  GridAboutHotel.swift
//  EffectTest
//
//  Created by Георгий Чебаков on 12/17/23.
//
import SwiftUI

struct GridAboutHotel: View {
    let description: String
    let peculiarities: [String]
    
    var body: some View {
        VStack(spacing: layout(12, width: false)) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150, maximum: 165), spacing: 8),
                                GridItem(.adaptive(minimum: 150, maximum: 165), spacing: 8)], spacing: 8) {
                ForEach(peculiarities, id: \.self) { text in
                    HStack(alignment: .center, spacing: layout(2, width: true)) {
                        Text(text)
                            .font(
                                Font.custom("SF Pro Display", size: 16)
                                    .weight(.medium)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(red: 0.51, green: 0.53, blue: 0.59))
                    }
                    .padding(.horizontal, layout(10, width: true))
                    .padding(.vertical, layout(5, width: true))
                    .background(Color(red: 0.98, green: 0.98, blue: 0.99))
                    .cornerRadius(5)
                }
            }
            if description != "" {
                Text(description)
                    .font(Font.custom("SF Pro Display", size: 16))
                    .foregroundColor(.black.opacity(0.9))
                    .frameCustom(width: 343, alignment: .topLeading)
            }
        }
    }
}
