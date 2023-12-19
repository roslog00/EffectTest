//
//  HotelViewModel.swift
//  EffectTest
//
//  Created by Георгий Чебаков on 12/15/23.
//
import Foundation

@MainActor
final class HotelViewModel: ObservableObject {
    @Published var hotelInfo: HotelModel?
    
    init() {
        Task {
            do {
                self.hotelInfo = try await giveData()
            } catch {
                print(error)
            }
        }
    }
    
    private func giveData() async throws  -> HotelModel {
        try await Network.fetchData(Network.ApiUrls.hotel)
    }
}
