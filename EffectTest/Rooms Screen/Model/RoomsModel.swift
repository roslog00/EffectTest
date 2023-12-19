//
//  RoomsModel.swift
//  EffectTest
//
//  Created by Георгий Чебаков on 12/15/23.
//

import Foundation


// MARK: - RoomsModel
struct RoomsModel: Codable {
    let rooms: [Room]
}

// MARK: - Room
struct Room: Codable, Hashable, Identifiable {
    let id: Int
    let name: String
    let price: Int
    let pricePer: String
    let peculiarities: [String]
    let imageUrls: ContiguousArray<String>

    enum CodingKeys: String, CodingKey {
        case id, name, price
        case pricePer = "price_per"
        case peculiarities
        case imageUrls = "image_urls"
    }
}
