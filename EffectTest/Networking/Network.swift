//
//  Network.swift
//  EffectTest
//
//  Created by Георгий Чебаков on 12/15/23.
//

import Foundation

final class Network {
    
    static let shared = Network()
    private init() {}
    
    enum ApiUrls: String {
        case hotel
        case rooms
        case reservations
        
        var url: URL? {
            switch self {
            case .hotel:
                URL(string: "https://run.mocky.io/v3/d144777c-a67f-4e35-867a-cacc3b827473")
            case .rooms:
                URL(string: "https://run.mocky.io/v3/8b532701-709e-4194-a41c-1a903af00195")
            case .reservations:
                URL(string: "https://run.mocky.io/v3/63866c74-d593-432c-af8e-f279d1a8d2ff")
            }
        }
    }
    
   @inline(__always) static func fetchData<T: Decodable>(_ urlCase: ApiUrls) async throws -> T {
        guard let url = urlCase.url else { throw URLError(.badURL) }
        let response = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        
        let result = try decoder.decode(T.self, from: response.0)
        
        return result
    }
}
