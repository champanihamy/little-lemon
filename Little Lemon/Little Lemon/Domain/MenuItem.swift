//
//  MenuItem.swift
//  Little Lemon
//
//  Created by Champani Hamy on 2026-01-19.
//

import Foundation


struct MenuItem: Codable, Identifiable{
    var id = UUID()
    let title: String
    let image: String
    let price: String
    
    var priceAsDouble: Double {
        Double(price) ?? 0.0
    }
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case price = "price"
        case image = "image"
    }
}
