//
//  HotelModel.swift
//  EffectTest
//
//  Created by Георгий Чебаков on 12/15/23.
//

import Foundation

//Модель для первого Api(отель)
struct HotelModel: Decodable {
    let id: Int
    let name, adress: String
    let minimalPrice: Int
    let priceForIt: String
    let rating: Int
    let ratingName: String
    let imageUrls: ContiguousArray<String>
    let aboutTheHotel: AboutTheHotel
    
    enum CodingKeys: String, CodingKey {
        case id, name, adress
        case minimalPrice = "minimal_price"
        case priceForIt = "price_for_it"
        case rating
        case ratingName = "rating_name"
        case imageUrls = "image_urls"
        case aboutTheHotel = "about_the_hotel"
    }
    
    init(from decoder: Decoder) throws {
        let contanier = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try contanier.decode(Int.self, forKey: .id)
        self.name = try contanier.decode(String.self, forKey: .name)
        self.adress = try contanier.decode(String.self, forKey: .adress)
        self.minimalPrice = try contanier.decode(Int.self, forKey: .minimalPrice)
        self.priceForIt = try contanier.decode(String.self, forKey: .priceForIt)
        self.rating =  try contanier.decode(Int.self, forKey: .rating)
        self.ratingName = try contanier.decode(String.self, forKey: .ratingName)
        self.imageUrls = try contanier.decode(ContiguousArray<String>.self, forKey: .imageUrls)
        self.aboutTheHotel = try contanier.decode(AboutTheHotel.self, forKey: .aboutTheHotel)
    }
}

struct AboutTheHotel: Decodable, Hashable {
    let description: String
    let peculiarities: [String]
}
