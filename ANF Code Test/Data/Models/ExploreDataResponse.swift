//
//  ExploreDataItem.swift
//  ANF Code Test
//
//  Created by E-Cartale on 09/12/2022.
//

import Foundation

struct ExploreDataItem: Codable{
    let title: String?
    let backgroundImage: String?
    let content: [Content]?
    let promoMessage: String?
    let topDescription: String?
    let bottomDescription: String?
}

struct Content: Codable{
    let target: String?
    let title: String?
}
