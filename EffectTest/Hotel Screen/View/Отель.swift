//
//  ContentView.swift
//  EffectTest
//
//  Created by Георгий Чебаков on 12/14/23.
//

import SwiftUI

struct Отель: Price, RatingNameAdress{
    @StateObject var vM = HotelViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false ) {
                ZStack {
                    VStack {
                        VStack(alignment: .leading, spacing: layout(16, width: false)) {
                            PhotoScroll(imageUrls: vM.hotelInfo?.imageUrls)
                                .padding(.top, layout(16, width: false))
                            
                            ratingNamePLace(name: vM.hotelInfo?.name ?? "" ,
                                            adress: vM.hotelInfo?.adress ?? "",
                                            hotelRating: vM.hotelInfo?.rating ?? 0,
                                            ratingName: vM.hotelInfo?.ratingName ?? "")
                            
                            price(price: vM.hotelInfo?.minimalPrice ?? 0, 
                                  pricePer: vM.hotelInfo?.priceForIt ?? "")
                                .padding(.bottom, layout(16, width: true))
                        }
                        .padding(.horizontal, layout(16, width: true))
                        .frameCustom(width: 375, alignment: .bottomLeading)
                        .background(.white)
                        .cornerRadius(12)
                        
                        VStack(alignment: .leading, spacing: layout(16, width: false)) {
                            aboutHotel()
                        }
                        .padding(.horizontal, layout(16, width: true))
                        .frameCustom(width: 375, alignment: .topLeading)
                        .background(.white)
                        .cornerRadius(12)
                        
                        
                        NavigationLink {
                            if let hotelName = vM.hotelInfo?.name{
                                Номер(hotelName: hotelName)
                                    .navigationBarBackButtonHidden(true)
                            }
                        } label: {
                            ZStack {
                                HStack {
                                    Text("К выбору номера")
                                        .font(Font.custom("SF Pro Display", size: 16)
                                                .weight(.medium))
                                        .kerning(0.1)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.white)
                                }
                                .padding(.bottom, layout(1, width: false))
                                .padding(.top, layout(15, width: false))
                                .padding(.bottom, layout(14, width: false))
                                .frameCustom(width: 343, height: 48, alignment: .center)
                                .background(Color(red: 0.05, green: 0.45, blue: 1))
                                .cornerRadius(15)
                            }
                            .padding(.top, layout(12, width: false))
                            .frameCustom(width: 375, height: 48)
                            .background(.white)
                        }
                    }
                    .padding(.top, layout(-60, width: false))
                }
                .background(Color(red: 0.96, green: 0.96, blue: 0.98))
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Отель")
                        .font(
                            Font.custom("SF Pro Display", size: 18)
                                .weight(.medium)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                }
            }
        }.ignoresSafeArea(.all)
    }
}

#Preview {
    Отель()
}

//MARK: About Hotel
extension Отель {
    @ViewBuilder
    fileprivate func aboutHotel() -> some View {
        VStack(spacing: layout(16, width: false)) {
            Text("Об отеле")
                .font(
                    Font.custom("SF Pro Display", size: 22)
                        .weight(.medium)
                )
                .foregroundColor(.black)
                .frameCustom(width: 343, alignment: .topLeading)
                .padding(.top, layout(16, width: false))
            
            if let peculiarities = vM.hotelInfo?.aboutTheHotel.peculiarities,
               let description = vM.hotelInfo?.aboutTheHotel.description {
                GridAboutHotel(description: description, peculiarities: peculiarities)
            }
            
            buttons()
                .padding(.bottom, layout(16, width: false))
        }
    }
    
    @ViewBuilder
    private func buttons() -> some View {
        VStack(alignment: .trailing, 
               spacing: layout(10, width: false)) {
            ForEach(0..<3) { numberLoop in
                Group {
                    button(loop: numberLoop)
                }
            }
        }
        .padding(layout(15, width: false))
        .background(Color(red: 0.98, green: 0.98, blue: 0.99))
        .cornerRadius(15)
    }
    
    @ViewBuilder
    private func button(loop num: Int) -> some View {
        HStack(alignment: .center,
               spacing: layout(12, width: true)) {
            HStack(alignment: .center,
                   spacing: 0) {
                Image(num == 0 ?
                      "emoji-happy" : num == 1 ?
                      "tick-square" : "close-square")
                    .frameCustom(width: 24, height: 24)
            }
            .padding(0)
            .frameCustom(width: 24,
                         height: 24,
                         alignment: .center)
            
            VStack(alignment: .leading,
                   spacing: layout(2, width: false)) {
                Text(num == 0 ?
                     "Удобства" : num == 1 ?
                     "Что включено" : "Что не включено")
                    .font(
                        Font.custom("SF Pro Display", size: 16)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(red: 0.17, green: 0.19, blue: 0.21))
                
                Text("Самое необходимое")
                    .font(
                        Font.custom("SF Pro Display", size: 14)
                            .weight(.medium)
                    )
                    .foregroundColor(Color(red: 0.51, green: 0.53, blue: 0.59))
            }
            
            Spacer()
            
            Button {} label: {
                HStack(alignment: .top, spacing: 10) {
                    Image("Vector 55")
                        .frameCustom(width: 6, height: 12)
                }
                .padding(.leading, 10)
                .padding(.trailing, 8)
                .padding(.vertical, 6)
            }.disabled(true)
        }
        if num != 2 {
            Divider()
                .frameCustom(width: 275, height: 0)
        }
    }
}

