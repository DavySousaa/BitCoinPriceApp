//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    var selectedCoin: String?
    var coinManager = CoinManager()
    @IBOutlet var currentPicker: UIPickerView!
    @IBOutlet var bitcoinLabel: UILabel!
    @IBOutlet var currencyLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPicker.dataSource = self
        currentPicker.delegate = self
        coinManager.delegate = self
    }

    @IBAction func resetButton(_ sender: UIButton) {
        self.currencyLabel.text = ""
        self.bitcoinLabel.text = "Select Coin"
        self.currentPicker.selectRow(0, inComponent: 0, animated: true)
    }
}

//MARK - UIPickerViewDataSource

extension ViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        coinManager.currencyArray[row]
    }
}


//MARK - UIPIckerViewDelegate

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCoin = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCoin!)
    }
}

//MARK - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = coin.valueToString
            if let currency = self.selectedCoin {
                self.currencyLabel.text = currency
            }
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
