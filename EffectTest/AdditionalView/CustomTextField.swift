//
//  TextField.swift
//  EffectTest
//
//  Created by Георгий Чебаков on 12/18/23.
//

import SwiftUI

enum TextFields: String, CaseIterable, Identifiable {
    var id: Int {
        set { }
        get { 0 }
    }
    
    case phoneNumber
    case mail
    case firstName
    case surName
    case birthday
    case nationality
    case passportNumber
    case passportValidityPeriod
    
    var caseInString: String {
        switch self {
        case .phoneNumber:
            return "Номер телефона"
        case .mail:
            return "Почта"
        case .firstName:
            return "Имя"
        case .surName:
            return "Фамилия"
        case .birthday:
            return "Дата рождения"
        case .nationality:
            return "Гражданство"
        case .passportNumber:
            return "Номер загранпаспорта"
        case .passportValidityPeriod:
            return "Срок действия загранпаспорта"
        }
    }
}

extension View {
    @ViewBuilder
    func customTextFieldWithClouser(optional: TextFields,
                         fail: Binding<Bool>,
                         component: Binding<String>,
                         clouser: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            if optional == .mail || optional == .phoneNumber {
                Text(optional.caseInString)
                    .font(Font.custom("SF Pro Display", size: 12))
                    .kerning(0.12)
                    .foregroundColor(Color(red: 0.66,
                                           green: 0.67,
                                           blue: 0.72))
            }
            
            clouser()
        }
        .padding(.leading, layout(16, width: true))
        .padding(.vertical, layout(10, width: false))
        .frameCustom(width: 343, alignment: .leading)
        .background(fail.wrappedValue == true &&
                    (component.wrappedValue == "" ||
                    component.wrappedValue.contains("*")) ?
                    Color.pink.opacity(0.3): Color(red: 0.96,
                                                   green: 0.96,
                                                   blue: 0.98))
        .cornerRadius(10)
    }
    
    func customTextFieldWithoutClouser(optional: TextFields,
                         fail: Binding<Bool>,
                         component: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            if optional == .firstName || optional == .surName {
                Text(optional.caseInString)
                    .font(Font.custom("SF Pro Display", size: 12))
                    .kerning(0.12)
                    .foregroundColor(Color(red: 0.66,
                                           green: 0.67,
                                           blue: 0.72))
            }
            
            HStack(spacing: 0) {
                TextField(optional.caseInString, text: component)
                    .font(Font.custom("SF Pro Display", size: 16))
                    .kerning(0.75)
                    .foregroundColor(Color(red: 0.08,
                                           green: 0.08,
                                           blue: 0.17))
            }
        }
        .padding(.leading, layout(16, width: true))
        .padding(.vertical, layout(optional == .firstName ||
                                   optional == .surName ? 10 : 16,
                                   width: false))
        .frameCustom(width: 343, alignment: .leading)
        .background(fail.wrappedValue == true
                    && component.wrappedValue == "" ?
                    Color(red: 235,
                          green: 87,
                          blue: 87).opacity(0.15):
                        Color(red: 0.96,
                              green: 0.96,
                              blue: 0.98))
        .cornerRadius(10)
    }
}
