//
//  Бронирование.swift
//  EffectTest
//
//  Created by Георгий Чебаков on 12/17/23.
//

import SwiftUI

@MainActor
struct Бронирование: RatingNameAdress, Formatters {
    @StateObject var vM = ReservationlViewModel()
    @Environment(\.dismiss) var dismiss
    
    //Contact
    @State var phoneNumber: String = "(***) ***-**-**"
    @FocusState var phoneFocus: Bool
    @State var mail: String = ""
    @FocusState var mailFocus: Bool
    
    //Tourists
    @State var touristData: [Tourist] = [Tourist(id: 1)]
    
    //InfoFails
    @State var phoneFail: Bool = false
    @State var mailFail: Bool = false
    @State var touristDataFail: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    Color(red: 0.96, green: 0.96, blue: 0.98).frameCustom(width: 375, height: 2)
                    
                    LazyVStack {
                        ratingNamePLace(name: vM.reservationInfo?.hotelName ?? "",
                                        adress: vM.reservationInfo?.hotelAdress ?? "",
                                        hotelRating: vM.reservationInfo?.horating ?? 0,
                                        ratingName: vM.reservationInfo?.ratingName ?? "")
                    }
                    .frameCustom(width: 343)
                    .padding(layout(16, width: false))
                    .background(.white)
                    .cornerRadius(12)
                    
                    aboutFly(inCity: vM.reservationInfo?.arrivalCountry ?? "",
                             toCity: vM.reservationInfo?.departure ?? "",
                             dates: "\(vM.reservationInfo?.tourDateStart ?? "") - \(vM.reservationInfo?.tourDateStop ?? "")",
                             nights: "\(vM.reservationInfo?.numberOfNights ?? 0)",
                             hotelName: vM.reservationInfo?.hotelName ?? "",
                             room: vM.reservationInfo?.room ?? "",
                             eat: vM.reservationInfo?.nutrition ?? "")
                    
                    buyersInfo()
                    
                    tourists()
                    
                    appendTourist()
                    
                    tour()
                    
                    payButton()
                }
                .background( Color(red: 0.96, green: 0.96, blue: 0.98))
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
                    Text("Бронирование")
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
    Бронирование()
}

//MARK: Reservation info - информация о бронировании
extension Бронирование {
    @ViewBuilder
    func aboutFly(inCity: String,
                  toCity: String,
                  dates: String,
                  nights: String,
                  hotelName: String,
                  room: String,
                  eat: String) -> some View {
        VStack(spacing: layout(16, width: false)) {
            ForEach(0..<7) { num in
                HStack{
                    Text(num == 0 ?
                         "Вылет из" : num == 1 ?
                         "Страна, город" : num == 2 ?
                         "Даты" : num == 3 ?
                         "Кол-во ночей" : num == 4 ?
                         "Отель" : num == 5 ?
                         "Номер" : "Питание")
                    
                      .font(Font.custom("SF Pro Display", size: 16))
                      .foregroundColor(Color(red: 0.51,
                                             green: 0.53,
                                             blue: 0.59))
                    Spacer()
                    
                    Text(num == 0 ?
                         inCity : num == 1 ?
                         toCity : num == 2 ?
                         dates : num == 3 ?
                         nights : num == 4 ?
                         hotelName : num == 5 ?
                         room : eat)
                      .font(Font.custom("SF Pro Display", size: 16))
                      .foregroundColor(.black)
                      .frameCustom(width: 203, alignment: .topLeading)
                }
            }
        }
        .frameCustom(width: 343)
        .padding(layout(16, width: false))
        .background(.white)
        .cornerRadius(12)
    }
}

//MARK: Buyer Info - Информация о покупателе
extension Бронирование {
    @ViewBuilder
    fileprivate func buyersInfo() -> some View {
        VStack(alignment: .leading) {
            Text("Информация о покупателе")
              .font(Font.custom("SF Pro Display", size: 22)
                  .weight(.medium))
              .foregroundColor(.black)
              .frameCustom(width: 343, alignment: .topLeading)
            
            VStack(spacing: layout(8, width: false)) {
                customTextFieldWithClouser(optional: .phoneNumber, 
                                           fail: $phoneFail,
                                           component: $phoneNumber) {
                    HStack(spacing: 0) {
                        Text("+7")
                            .font(Font.custom("SF Pro Display", size: 16))
                            .kerning(0.75)
                            .foregroundColor(Color(red: 0.08,
                                                   green: 0.08,
                                                   blue: 0.17))
                        TextField("(***) ***-**-**", text: $phoneNumber)
                        .font(Font.custom("SF Pro Display", size: 16))
                        .kerning(0.75)
                        .keyboardType(.numberPad)
                        .foregroundColor(Color(red: 0.08,
                                               green: 0.08,
                                               blue: 0.17))
                        .focused($phoneFocus)
                        .onChange(of: phoneNumber) { oldValue, _ in
                            var mask = "(***) ***-**-**"
                            phoneNumber = numberFortmatter(mask: &mask, 
                                                           phone: oldValue)
                        }
                        .onChange(of: phoneFocus) { oldValue, newValue in
                            if phoneNumber.contains("*") && newValue == false  {
                                phoneFail = true
                            }
                        }
                    }
                }
                
                customTextFieldWithClouser(optional: .mail,
                                           fail: $mailFail,
                                           component: $mail) {
                    HStack(spacing: 0) {
                        TextField(text: $mail) {
                            Text("exemple@mail")
                                .foregroundColor(Color(red: 0.66,
                                                       green: 0.67,
                                                       blue: 0.72))
                        }
                        .font(Font.custom("SF Pro Display", size: 16))
                        .kerning(0.75)
                        .keyboardType(.emailAddress)
                        .foregroundColor(Color(red: 0.08,
                                               green: 0.08,
                                               blue: 0.17))
                        .focused($mailFocus)
                    }.onChange(of: mailFocus) { oldValue, newValue in
                        if (String().isValidEmail(email: mail) ||
                            mail.isEmpty) && mailFocus == false {
                            mailFail = true
                        }
                    }
                }
                
                Text("Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту")
                  .font(Font.custom("SF Pro Display", size: 14))
                  .foregroundColor(Color(red: 0.51,
                                         green: 0.53,
                                         blue: 0.59))
                  .frameCustom(width: 343, alignment: .topLeading)
            }
        }
        .padding(.vertical, layout(16, width: false))
        .padding(.horizontal, layout(16, width: true))
        .frameCustom(width: 375)
        .background(.white)
        .cornerRadius(12)
    }
}

//MARK: Tourists - данные о туристах
extension Бронирование {
    @ViewBuilder
    fileprivate func tourists() -> some View {
        ForEach(touristData) { oneOfTurists in
            LazyVStack(spacing: layout(20, width: false)) {
                HStack {
                    Text(String().countdownEnding(oneOfTurists.id) + " турист")
                      .font(Font.custom("SF Pro Display", size: 22)
                          .weight(.medium))
                      .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button {
                        if let index = touristData.firstIndex(where: {$0 == oneOfTurists}) {
                            withAnimation(.easeInOut) {
                                touristData[index].closed.toggle()
                            }
                        }
                    } label: {
                        HStack(alignment: .center, spacing: 10) {
                            Image("Vector 56")
                                .resizable()
                                .rotationEffect(oneOfTurists.closed ? .zero : .degrees(-90))
                                .frameCustom(width: 6, height: 12)
                        }
                        .padding(.vertical, 12)
                        .frameCustom(width: 32, height: 32, alignment: .center)
                        .background(Color(red: 0.05, green: 0.45, blue: 1).opacity(0.1))
                        .cornerRadius(6)
                    }
                }
                if !oneOfTurists.closed {
                    TouristView(tourist: oneOfTurists, fail: $touristDataFail)
                }
            }
            .padding(layout(16, width: false))
            .frameCustom(width: 375)
            .background(.white)
            .cornerRadius(12)
        }
    }
    
    @ViewBuilder
    fileprivate func appendTourist() -> some View {
        HStack {
            Text("Добавить туриста")
              .font(Font.custom("SF Pro Display", size: 22)
                  .weight(.medium))
              .foregroundColor(.black)
            
            Spacer()
            
            Button {
                if let lastId = touristData.last?.id {
                    touristData.append(Tourist(id: lastId + 1))
                }
            } label: {
                HStack(alignment: .center, spacing: 10) {
                    Image("Frame 609")
                        .resizable()
                        .frameCustom(width: 24, height: 24)
                }
                .frameCustom(width: 32, height: 32, alignment: .center)
                .background(Color(red: 0.05, green: 0.45, blue: 1))
                .cornerRadius(6)
            }
        }
        .padding(layout(16, width: false))
        .frameCustom(width: 375)
        .frame(maxHeight: layout(430, width: false))
        .background(.white)
        .cornerRadius(12)
    }
}


//MARK: Tour
extension Бронирование {
    @ViewBuilder
    fileprivate func tour() -> some View {
        VStack(alignment: .leading, spacing: layout(16, width: false)) {
            HStack {
                Text("Тур")
                  .font(Font.custom("SF Pro Display", size: 16))
                  .foregroundColor(Color(red: 0.51, green: 0.53, blue: 0.59))
                
                Spacer()
                
                Text("\(vM.reservationInfo?.tourPrice ?? 0)")
                  .font(Font.custom("SF Pro Display", size: 16))
                  .multilineTextAlignment(.trailing)
                  .foregroundColor(.black)
            }
            .frameCustom(width: 343, height: 19)
            
            HStack {
                Text("Топливный сбор")
                  .font(Font.custom("SF Pro Display", size: 16))
                  .foregroundColor(Color(red: 0.51, green: 0.53, blue: 0.59))
                
                Spacer()
                
                Text("\(vM.reservationInfo?.fuelCharge ?? 0)")
                  .font(Font.custom("SF Pro Display", size: 16))
                  .multilineTextAlignment(.trailing)
                  .foregroundColor(.black)
            }
            .frameCustom(width: 343, height: 19)
            
            HStack {
                Text("Сервисный сбор")
                  .font(Font.custom("SF Pro Display", size: 16))
                  .foregroundColor(Color(red: 0.51, green: 0.53, blue: 0.59))
                
                Spacer()
                
                Text("\(vM.reservationInfo?.serviceCharge ?? 0)")
                  .font(Font.custom("SF Pro Display", size: 16))
                  .multilineTextAlignment(.trailing)
                  .foregroundColor(.black)
            }
            .frameCustom(width: 343, height: 19)
            
            HStack {
                Text("К оплате")
                  .font(Font.custom("SF Pro Display", size: 16))
                  .foregroundColor(Color(red: 0.51, green: 0.53, blue: 0.59))
                
                Spacer()
                
                Text(String().sum(vM.reservationInfo?.tourPrice,
                                  vM.reservationInfo?.serviceCharge,
                                  vM.reservationInfo?.fuelCharge))
                    .font(Font.custom("SF Pro Display", size: 16)
                            .weight(.semibold))
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(Color(red: 0.05, green: 0.45, blue: 1))
            }
            .frameCustom(width: 343, height: 19)
        }
        .padding(layout(16, width: true))
        .background(.white)
        .cornerRadius(12)
    }
    
    @ViewBuilder
    fileprivate func payButton() -> some View {
        NavigationLink {
            Оплачено()
                .navigationBarBackButtonHidden(true)
        } label: {
            HStack(alignment: .center, spacing: 0) {
                Text("Оплатить " + String().sum(vM.reservationInfo?.tourPrice,
                                                vM.reservationInfo?.serviceCharge,
                                                    vM.reservationInfo?.fuelCharge))
                    .font(Font.custom("SF Pro Display", size: 16)
                        .weight(.medium))
                    .kerning(0.1)
                    .multilineTextAlignment(.center)
                  .foregroundColor(.white)
            }
            .padding(.vertical, layout(15, width: false))
            .frameCustom(width: 343, height: 48, alignment: .center)
            .background(Color(red: 0.05, green: 0.45, blue: 1))
            .cornerRadius(15)
        }
        .disabled(validation() == true ?
                                  true : phoneFail ?
                                  true : mailFail ?
                                  true : touristDataFail ?
                                  true : false)
        .frameCustom(width: 375, height: 68, alignment: .top)
        .padding(.top, layout(12, width: false))
        .background(.white)
    }
    
    @MainActor
    private func validation()  -> Bool? {
        if mail.isEmpty || !String().isValidEmail(email: mail) { mailFail = true }
        if phoneNumber.contains("*") { phoneFail = true }
        touristData.forEach { tourist in
            if tourist.firstName.isEmpty ||
                tourist.surName.isEmpty ||
                tourist.nationality.isEmpty ||
                tourist.passportNumber.isEmpty ||
                tourist.passportValidityPeriod.isEmpty {
                self.touristDataFail = true
            }
        }
        return true
    }
}
