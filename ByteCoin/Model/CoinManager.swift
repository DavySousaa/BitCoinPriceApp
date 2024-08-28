//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

// API Key: B8338282-CBCE-422D-836F-A504626FAABC

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "B8338282-CBCE-422D-836F-A504626FAABC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(urlString: urlString)
        print(currency)
    }
    
    func performRequest (urlString: String){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    delegate?.didFailWithError(error: error!)
                    return
                }
                _ = String(data: data!, encoding: .utf8)
                
                if let safeDate  = data {
                    if let coin = self.parseJSON(coinDate: safeDate) {
                        delegate?.didUpdateCoin(self, coin: coin)
                    }

                }
                
            }
            task.resume()
        }
    }
    
    func parseJSON(coinDate: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decoderDate = try decoder.decode(CoinDate.self, from: coinDate)
            let value = decoderDate.rate
            
            print(value)
            return CoinModel(value: value)
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
