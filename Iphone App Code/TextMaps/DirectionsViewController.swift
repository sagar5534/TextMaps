//
//  DirectionsViewController.swift
//  TextMaps
//
//  Created by Sagar Patel on 2018-12-19.
//  Copyright © 2018 Sagar Patel. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import SwiftyJSON

class DirectionsViewController: UIViewController, UITextFieldDelegate {
    
    //References
    @IBOutlet weak var startTxt: UITextField!
    @IBOutlet weak var destinationTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTxt.delegate = self
        destinationTxt.delegate = self
    }
    
    
    @IBAction func sendDirections(_ sender: UIButton) {
        
        //Checks textfields
        if (!startTxt.hasText){
            
            self.startTxt.layer.borderWidth = 1;
            startTxt.layer.borderColor = UIColor.red.cgColor;
            startTxt.layer.cornerRadius = 5;
            startTxt.clipsToBounds = true;
            startTxt.textColor = UIColor.red;
            startTxt.placeholder = "Please Enter an Address"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.startTxt.layer.borderWidth = 0;
                self.startTxt.textColor = UIColor.black;
                self.startTxt.placeholder = "";
            }
            
        }
        
        if(!destinationTxt.hasText){
            print("hey");
            destinationTxt.layer.borderWidth = 1;
            destinationTxt.layer.borderColor = UIColor.red.cgColor;
            destinationTxt.layer.cornerRadius = 5;
            destinationTxt.clipsToBounds = true;
            destinationTxt.textColor = UIColor.red;
            destinationTxt.placeholder = "Please Enter an Address"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.destinationTxt.layer.borderWidth = 0;
                self.destinationTxt.textColor = UIColor.black;
                self.destinationTxt.placeholder = "";
            }
            
        }
        
        if (destinationTxt.hasText && startTxt.hasText){
            //If Correct textfields
            print("Sending");
            
            //let sender = "16476298391";
            
            var start = startTxt.text!
            start = start.replacingOccurrences(of: " ", with: "+")
            start = start.replacingOccurrences(of: ",", with: "+")
            start = start.replacingOccurrences(of: "++", with: "+")
            
            var end = destinationTxt.text!;
            end = end.replacingOccurrences(of: " ", with: "+")
            end = end.replacingOccurrences(of: ",", with: "+")
            end = end.replacingOccurrences(of: "++", with: "+")
            
            var url = "https://sagar.lib.id/textmaps@dev/?sender=16476298391&startDir=";
            url = url + start + "&endDir=";
            url = url + end;
            url = url + "&method=drive";
            
            print(url);
            
            Alamofire.request(url).responseJSON { response in
                if let result = response.result.value {
                    print(result);
                    let json = JSON(result)
                    print(json["url"])
                    print(json["explanation"])
                }
            }
            
            print("Complete");
            
        }
        
    }
    
    
    @IBAction func sendUber(_ sender: UIButton) {
        
        //Checks textfields
        if (!startTxt.hasText){
            
            self.startTxt.layer.borderWidth = 1;
            startTxt.layer.borderColor = UIColor.red.cgColor;
            startTxt.layer.cornerRadius = 5;
            startTxt.clipsToBounds = true;
            startTxt.textColor = UIColor.red;
            startTxt.placeholder = "Please Enter an Address"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.startTxt.layer.borderWidth = 0;
                self.startTxt.textColor = UIColor.black;
                self.startTxt.placeholder = "";
            }
            
        }
        
        if(!destinationTxt.hasText){
            
            destinationTxt.layer.borderWidth = 1;
            destinationTxt.layer.borderColor = UIColor.red.cgColor;
            destinationTxt.layer.cornerRadius = 5;
            destinationTxt.clipsToBounds = true;
            destinationTxt.textColor = UIColor.red;
            destinationTxt.placeholder = "Please Enter an Address"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.destinationTxt.layer.borderWidth = 0;
                self.destinationTxt.textColor = UIColor.black;
                self.destinationTxt.placeholder = "";
            }
            
        }
        
    }
    
    //Text Field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
