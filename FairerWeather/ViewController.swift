//
//  ViewController.swift
//  FairerWeather
//
//  Created by Jacob Finn on 10/24/18.
//  Copyright © 2018 Jacob Finn. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let apiKeys = APIKeys()
        // Do any additional setup after loading the view, typically from a nib
        let darkSkyUrl = "https://api.darksky.net/forecast/" + apiKeys.darkSkyKey
        let latitude = "37.8267"
        let longitude = "-122.4233"
        let url = darkSkyUrl + "/" + latitude + "," + longitude
        print(url)
        
        
        let request = Alamofire.request(url)
        request.responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
        
        
    }
    
    
}

