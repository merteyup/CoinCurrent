//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Eyup Mert on 11/04/2022.
//

import Foundation

// MARK: - Protocols

protocol CoinManagerDelegate {
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinData)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    // MARK: - Variables
    var baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "8EA0D9F4-4109-49D0-9D3F-1CFB5193FFAF"
    var delegate : CoinManagerDelegate?
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    
    // MARK: - Functions
    mutating func getCoinPrice(for currency: String) {
        baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=8EA0D9F4-4109-49D0-9D3F-1CFB5193FFAF"
        performRequest(with: baseURL)
    }
    
    mutating func fetchCoin(currency: String) {
            baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/\(currency)?apikey=8EA0D9F4-4109-49D0-9D3F-1CFB5193FFAF"
            print("URLSON \(baseURL)")

            performRequest(with: baseURL)
        }
    
    func performRequest(with urlString: String) {
           if let url = URL(string: urlString) {
               let session = URLSession(configuration: .default)
               let task = session.dataTask(with: url) { (data, response, error) in
                   if error != nil {

                       return
                   }
                   if let safeData = data {
                       if let coin = self.parseJSON(safeData) {
                           self.delegate?.didUpdateCoin(self, coin: coin)
                       }
                       
                       
                    //   print(String(data: data!, encoding: .utf8) )

                   }
               }
               task.resume()
           }
       }
 
    func parseJSON(_ coinData: Data) -> CoinData? {
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(CoinData.self, from: coinData)
                let asset_id_base = decodedData.asset_id_base
                let asset_id_quote = decodedData.asset_id_quote
                let rate = decodedData.rate
                
                let coin = CoinData(asset_id_base: asset_id_base, asset_id_quote: asset_id_quote, rate: rate)
                
                print("ParsedCoin: \(coin)")
                
                return coin
                
            } catch {
                delegate?.didFailWithError(error: error)
                return nil
            }
        }
    
}
