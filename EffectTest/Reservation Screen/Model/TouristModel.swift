//
//  TouristModel.swift
//  EffectTest
//
//  Created by Георгий Чебаков on 12/18/23.
//

//MARK: Турист
struct Tourist: Identifiable, Equatable {
    var id: Int
    var firstName: String = ""
    var surName: String = ""
    var birthday: String = ""
    var nationality: String = ""
    var passportNumber: String = ""
    var passportValidityPeriod: String = ""
    var closed: Bool = true
}
