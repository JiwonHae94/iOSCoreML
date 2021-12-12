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
        getImage()
        
    }
    
    private func getImage(){
        // Create a URL object
        let url = URL(string: imageURL)
        
        // check URL isn't nil
        guard url != nil else{
            print("Couldn't get URL object")
            return
        }
        
        // get URL session
        let session = URLSession.shared
        
        // Create the data task
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            // Check that there are no errors and that there was data
            if error == nil && data != nil{
                self.imageData = data
            }
        }
        
        // Start the data task
        dataTask.resume()
    }
}

