//
//  ViewController.swift
//  Whats The Weather
//
//  Created by MacOS on 2/26/19.
//  Copyright © 2019 MacOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var textField: UITextField!
    
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        if let url = URL(string: "https://www.weather-forecast.com/locations/" + textField.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest") {
        
        let request = NSMutableURLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            var message = ""
            
            
            if let error = error {
                print(error)
            } else {
                
                if let unwrappedData = data {
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                    
                    var stringSeparator = "<p class=\"b-forecast__table-description-content\"><span class=\"phrase\">"
                    
                    if let contentArray = dataString?.components(separatedBy: stringSeparator){
                        
                        if contentArray.count > 1 {
                            
                            stringSeparator = "</span>"
                            
                            
                            let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                            
                            if newContentArray.count > 1 {
                                
                                message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                
                                
                            }
                            
                            
                            
                            
                        }
                        
                    }
                    
                }
                
                
                
            }
            
            
            if message == "" {
                message = "The weather there couldn't be found. Please try again."
            }
            
            DispatchQueue.main.sync(execute: {
                print(message)
                
                self.resultLabel.text =  message
            })
        }
        task.resume()
    }
        else {
            resultLabel.text = "The weather there couldn't be found. Please try again."
        }
    
    
}
    
    override func viewDidLoad() {
       resultLabel.text = " "
        super.viewDidLoad()
       
    }


}


