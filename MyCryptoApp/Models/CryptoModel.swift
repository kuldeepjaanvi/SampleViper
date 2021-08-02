//
//  CryptoModel.swift
//  MyCryptoApp
//
//  Created by Apple on 31/07/21.
//

import Foundation

struct CryptoModel: Codable {
    
    // MARK: - Properties
    var id: String?
    var rank: String?
    var symbol: String?
    var name: String?
    var supply: String?
    var maxSupply: String?
    var volumeUsd24Hr: String?
    var priceUsd: String?
    var vwap24Hr: String?
    var explorer: String?
    var changePercent24Hr: String?

    

}
