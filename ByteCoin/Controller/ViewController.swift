//
//  ViewController.swift
//  ByteCoin
//
//  Created by Eyup Mert on 11/04/2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Variables
    var coinManager = CoinManager()
    
    // MARK: - Outlets
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    // MARK: - Statements
    override func viewDidLoad() {
        super.viewDidLoad()

        coinManager.delegate = self
        
    }

}

// MARK: - Extensions

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.fetchCoin(currency: selectedCurrency)
        
    }
    
    
}

extension ViewController: CoinManagerDelegate {
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinData) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = String(format: "%.2f", coin.rate)
            self.currencyLabel.text = coin.asset_id_quote
        }
    }
    
    
   
}
