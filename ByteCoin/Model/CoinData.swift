//
//  CoinData.swift
//  ByteCoin
//
//  Created by Eyup Mert on 11/04/2022.
//

import Foundation


struct CoinData : Codable {

    
    // MARK: - Variables
    let asset_id_base : String
    let asset_id_quote : String
    let rate : Double
    
    
}
