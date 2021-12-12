//
//  Animal.swift
//  iOSCoreML
//
//  Created by Jiwon_Hae on 2021/12/13.
//

import Foundation

class Animal : Decodable, Identifiable{
    // url for the image
    var imageURL : String
    
    // image data
    var imageData : Data?
    
    init(){
        self.imageURL = ""
        self.imageData = nil
    }
    
    init?(json: [String: Any]){
        
        // check that JSON has a url
        guard let imageURL = json["url"] as? String else{
            return nil
        }
        
        
        // Set the ainmal propreties
        self.imageURL = imageURL
        self.imageData = nil
        
        
        // Download the image data
        self.imageData = getImage()
        
    }
    
    private func getImage(){
        
    }
}

