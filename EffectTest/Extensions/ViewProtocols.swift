//
//  ViewProtocols.swift
//  EffectTest
//
//  Created by Георгий Чебаков on 12/17/23.
//
import SwiftUI

//MARK: Rating, Name and Adress protocol
protocol RatingNameAdress: View {}

extension RatingNameAdress {
    @ViewBuilder
    func ratingNamePLace(name: String,
                         adress: String,
                         hotelRating: Int,
                         ratingName: String) -> some View {
        VStack(alignment: .leading, spacing: layout(8, width: false)) {
            rating(hotelRating: hotelRating,
                   ratingName: ratingName)
            
            Text(name)
                .font(Font.custom("SF Pro Display",size: 22)
                        .weight(.medium))
                .foregroundColor(.black)
            
            Button {} label: {
                Text(adress)
                    .font(Font.custom("SF Pro Display",size: 14)
                        .weight(.medium))
                    .foregroundColor(Color(red: 0.05,
                                           green: 0.45,
                                           blue: 1))
            }.disabled(true)
        }.frameCustom(width: 343, alignment: .topLeading)
    }
    
    @ViewBuilder
    func rating(hotelRating: Int, ratingName: String) -> some View {
        HStack(alignment: .center,
               spacing: layout(2, width: true)) {
            Image("Icons")
                .frameCustom(width: 15,height: 15)
            
            Text("\(hotelRating) \(ratingName)")
                .font(
                    Font.custom("SF Pro Display", size: 16)
                        .weight(.medium)
                )
                .multilineTextAlignment(.center)
                .foregroundColor(Color(red: 1, 
                                       green: 0.66,
                                       blue: 0))
        }
        .padding(.horizontal, layout(10, width: true))
        .padding(.vertical, layout(5, width: true))
        .background(Color(red: 1,
                          green: 0.78,
                          blue: 0).opacity(0.2))
        .cornerRadius(5)
    }
}


//MARK: Price protocol
protocol Price: View {}

extension Price {
    @ViewBuilder
    func price(price: Int, pricePer: String) -> some View {
        HStack(spacing: layout(8, width: true)) {
            Text("\(price)")
              .font(Font.custom("SF Pro Display", size: 30)
                  .weight(.semibold))
              .foregroundColor(.black)
            
            Text(pricePer)
              .font(Font.custom("SF Pro Display", size: 16))
              .foregroundColor(Color(red: 0.51,
                                     green: 0.53,
                                     blue: 0.59))
        }
    }
}

//MARK: Formaters
protocol Formatters: View {
    func numberFortmatter(mask: inout String, phone: String) -> String
}


extension Formatters {
    func numberFortmatter(mask: inout String, phone: String) -> String {
        let number = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var index = number.startIndex
        for _ in mask where index < number.endIndex {
            mask.insert(number[index], at: mask.firstIndex(of: "*")!)
            mask.remove(at: mask.firstIndex(of: "*")!)
            index = mask.index(after: index)
        }
        return mask
    }
}
