//
//  ResponseModel.swift
//  MyCryptoApp
//
//  Created by Apple on 01/08/21.
//

import Foundation

struct ResponseModel: Codable {
  
    let data : [CryptoModel]?
    enum CodingKeys: String, CodingKey {
        case data = "data"

    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        data = try values.decodeIfPresent([CryptoModel].self, forKey: .data)

    }

}
