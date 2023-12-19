//
//  ReservationViewModel.swift
//  EffectTest
//
//  Created by Георгий Чебаков on 12/17/23.
//

import Foundation

@MainActor
final class ReservationlViewModel: ObservableObject {
    @Published var reservationInfo: ReservationModel?
    
    init() {
        Task {
            do {
                self.reservationInfo = try await giveData()
            } catch {
                print(error)
            }
        }
    }
    
    private func giveData() async throws  -> ReservationModel {
        try await Network.fetchData(Network.ApiUrls.reservations)
    }
}
