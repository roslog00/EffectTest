//
//  Номер.swift
//  EffectTest
//
//  Created by Георгий Чебаков on 12/17/23.
//

import SwiftUI

struct Номер: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vM = RoomslViewModel()
    let hotelName: String
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Color(red: 0.96, green: 0.96, blue: 0.98).frameCustom(width: 375, height: 2)
        
                    ForEach(vM.roomsInfo?.rooms ?? [], id: \.self) { room in
                        RoomView(room: room)
                    }
                }
                .background(Color(red: 0.96, green: 0.96, blue: 0.98))
            }
            .padding(.top, layout(-45, width: false))
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
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
                }
                ToolbarItem(placement: .principal) {
                    Text(hotelName)
                        .font(
                            Font.custom("SF Pro Display", size: 18)
                                .weight(.medium)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    Номер(hotelName: "Steigenberger Makadi")
}

struct RoomView: Price {
    @State private(set) var room: Room
    
    var body: some View {
        VStack(alignment: .leading, spacing: layout(8, width: true)) {
            PhotoScroll(imageUrls: room.imageUrls)
            
            Text(room.name)
                .font(
                    Font.custom("SF Pro Display", size: 22)
                        .weight(.medium)
                )
                .foregroundColor(.black)
                .frameCustom(width: 343, alignment: .topLeading)
            
            GridAboutHotel(description: "", peculiarities: room.peculiarities)
            
            aboutRooms()
            
            price(price: room.price, pricePer: room.pricePer)
            
            NavigationLink {
                Бронирование()
                    .navigationBarBackButtonHidden(true)
            } label: {
                button()
            }
        }
        .frameCustom(width: 343, alignment: .top)
        .padding(.vertical, layout(7, width: false))
        .padding(.horizontal, layout(16, width: true))
        .background(.white)
        .cornerRadius(12)
    }
}

//MARK: For Room
extension RoomView {
    @ViewBuilder
    fileprivate func aboutRooms() -> some View {
        HStack(alignment: .center, spacing: layout(2, width: true)) {
            Text("Подробнее о номере")
                .font(
                    Font.custom("SF Pro Display", size: 16)
                        .weight(.medium)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 0.05, green: 0.45, blue: 1))
            
            Button {} label: {
                HStack(alignment: .top, spacing: 10) {
                    Image("Vector 56")
                        .frame(width: 6, height: 12)
                        .foregroundStyle(Color(red: 0.05, green: 0.45, blue: 1))
                }
                .padding(.leading, layout(10, width: true))
                .padding(.trailing, layout(8, width: true))
                .padding(.vertical, layout(6, width: false))
            }.disabled(true)
        }
        .padding(.leading, layout(10, width: true))
        .padding(.trailing, layout(2, width: true))
        .padding(.vertical, layout(5, width: false))
        .background(Color(red: 0.05, green: 0.45, blue: 1).opacity(0.1))
        .cornerRadius(5)
    }
    
    @ViewBuilder
    fileprivate func button() -> some View {
        HStack {
            Text("Выбрать номер")
                .font(
                    Font.custom("SF Pro Display", size: 16)
                        .weight(.medium)
                )
                .kerning(0.1)
                .foregroundColor(.white)
        }
        .padding(.top, layout(15, width: false))
        .padding(.bottom, layout(14, width: false))
        .frame(width: 343, height: 48, alignment: .center)
        .background(Color(red: 0.05, green: 0.45, blue: 1))
        .cornerRadius(15)
    }
}

//MARK: Реализация с List

//NavigationView {
//    List {
//        ForEach(vM.roomsInfo?.rooms ?? []) { room in
//            RoomView(room: room)
//        }
//    }
//    .padding(.top, layout(-20, width: false))
//    .frameCustom(width: 410, alignment: .top)
//    .scrollContentBackground(.visible)
//    .listRowSpacing(8)
//    .toolbar {
//        HStack(spacing: layout(50, width: true)) {
//            Button(action: {
//                dismiss()
//            }) {
//                HStack {
//                    Image("Vector 55")
//                        .frameCustom(width: 6, height: 12)
//                        .rotationEffect(.degrees(180))
//                }
//                .padding(.leading, layout(8, width: true))
//                .padding(.trailing, layout(10, width: true))
//                .padding(.vertical, layout(5, width: false))
//                .frameCustom(width: 32, height: 32, alignment: .center)
//                .cornerRadius(50)
//            }
//            
//            Text(hotelName)
//                .font(
//                    Font.custom("SF Pro Display", size: 18)
//                        .weight(.medium)
//                )
//                .multilineTextAlignment(.center)
//                .foregroundColor(.black)
//        }.frameCustom(width: 343, alignment: .leading)
//    }
//}
