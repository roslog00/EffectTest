//
//  RoomsViewModel.swift
//  EffectTest
//
//  Created by Георгий Чебаков on 12/17/23.
//
import Foundation

@MainActor
final class RoomslViewModel: ObservableObject {
    @Published var roomsInfo: RoomsModel?
    
    init() {
        Task {
            do {
                self.roomsInfo = try await giveData()
            } catch {
                print(error)
            }
        }
    }
    
    private func giveData() async throws  -> RoomsModel {
        try await Network.fetchData(Network.ApiUrls.rooms)
    }
}
