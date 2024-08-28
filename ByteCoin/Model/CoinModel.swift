//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Davy Sousa on 27/08/24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let value: Double
    
    var valueToString: String {
        return String(format: "%.1f", value)
    }
}
