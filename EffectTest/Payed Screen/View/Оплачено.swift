//
//  Оплачено.swift
//  EffectTest
//
//  Created by Георгий Чебаков on 12/18/23.
//

import SwiftUI

struct Оплачено: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: layout(234, width: false)) {
                VStack(spacing: layout(20, width: false)) {
                    HStack(alignment: .center) {
                        Image("Party Popper")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                            .frameCustom(width: 44, height: 44)
                            .padding(.top, layout(25, width: false))
                    }
                    .frameCustom(width: 94,height: 94, alignment: .top)
                    .background(Color(red: 0.96, green: 0.96, blue: 0.98))
                    .cornerRadius(1000)
                    
                    Text("Ваш заказ принят в работу")
                        .font(Font.custom("SF Pro Display", size: 22)
                            .weight(.medium))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding(.top, layout(12, width: false))
                        .frameCustom(width: 343,height: 26, alignment: .top)
                    
                    Text("Подтверждение заказа №104893 может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление.")
                        .font(Font.custom("SF Pro Display", size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.51, green: 0.53, blue: 0.59))
                        .frameCustom(width: 329, height: 95, alignment: .top)
                }.padding(.top, layout(172, width: false))
                
                NavigationLink {
                    Отель()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    ZStack {
                        HStack(alignment: .center, spacing: 0) {
                            Text("Супер!")
                                .font(Font.custom("SF Pro Display", size: 16)
                                    .weight(.medium))
                                .kerning(0.1)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .frameCustom(width: 343, alignment: .center)
                        }
                        .padding(.vertical, layout(15, width: false))
                        .frameCustom(width: 343, height: 48, alignment: .center)
                        .background(Color(red: 0.05, green: 0.45, blue: 1))
                        .cornerRadius(15)
                    }
                    .frameCustom(width: 375, height: 88)
                    .background(.white)
                    .overlay(
                        Rectangle()
                            .inset(by: -0.5)
                            .stroke(Color(red: 0.91, green: 0.91, blue: 0.93), lineWidth: 1)
                    )
                }
            }
        }
        .ignoresSafeArea()
        .navigationBarItems(leading:
                                Button(action: {
            dismiss()
        }) {
            HStack {
                Image("Vector 55")
                    .frameCustom(width: 6, height: 12)
                    .rotationEffect(.degrees(180))
            }
            .padding(.leading, layout(8, width: true))
            .padding(.trailing, layout(10, width: true))
            .padding(.vertical, layout(5, width: false))
            .frameCustom(width: 32, height: 32, alignment: .center)
            .cornerRadius(50)
        }
        )
        .navigationTitle("Заказ оплачен")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    Оплачено()
}
