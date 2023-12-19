//
//  Tourist.swift
//  EffectTest
//
//  Created by Георгий Чебаков on 12/18/23.
//

import SwiftUI

struct TouristView: Formatters {
    @State var tourist: Tourist
    @Binding var fail: Bool
    
    var body: some View {
        VStack(spacing: layout(8, width: false)) {
            customTextFieldWithoutClouser(optional: .firstName,
                                          fail: $fail,
                                          component: $tourist.firstName)
            customTextFieldWithoutClouser(optional: .surName, 
                                          fail: $fail,
                                          component: $tourist.surName)
            customTextFieldWithoutClouser(optional: .nationality, 
                                          fail: $fail,
                                          component: $tourist.nationality)
            customTextFieldWithoutClouser(optional: .passportNumber, 
                                          fail: $fail,
                                          component: $tourist.passportNumber)
            customTextFieldWithoutClouser(optional: .passportValidityPeriod, 
                                          fail: $fail,
                                          component: $tourist.passportValidityPeriod)
        }
    }
}

#Preview {
    TouristView(tourist: Tourist(id: 74836), fail: .constant(true))
}
