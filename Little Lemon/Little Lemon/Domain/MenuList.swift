//
//  MenuList.swift
//  Little Lemon
//
//  Created by Champani Hamy on 2026-01-19.
//

import Foundation


struct MenuList: Codable{
    let menu: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case menu = "menu"
    }
}
