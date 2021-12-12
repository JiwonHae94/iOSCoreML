//
//  Animal.swift
//  iOSCoreML
//
//  Created by Jiwon_Hae on 2021/12/13.
//

import Foundation
import CoreML
import Vision

struct Result : Identifiable{
    var id = UUID()
    var imageLabel : String
    var confidence : Double
}

class Animal : Identifiable {
    // url for the image
    var imageURL : String
    
    // image data
    var imageData : Data?
    
    // Classified results
    var results : [Result]
    
    let modelFile = try! MobileNetV2(configuration: MLModelConfiguration())
    
    init(){
        self.imageURL = ""
        self.imageData = nil
        self.results = []
    }
    
    init?(json: [String: Any]){
        
        // check that JSON has a url
        guard let imageURL = json["url"] as? String else{
            return nil
        }
        
        
        // Set the ainmal propreties
        self.imageURL = imageURL
        self.imageData = nil
        self.results = []
        
        
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
                
                // Classify the image
                self.classifyAnimal()
            }
        }
        
        // Start the data task
        dataTask.resume()
    }
    
 
    func classifyAnimal(){
        // Get a reference to the model
        let model = try! VNCoreMLModel(for: modelFile.model)
        
        // Create an image handler
        let handler = VNImageRequestHandler(data: imageData!)
        
        // create a request to the model
        let request = VNCoreMLRequest(model: model) { request, error in
            
            guard let results = request.results as? [VNClassificationObservation] else {
                print("couldn't classify animal")
                return
            }
            
            
            // Update the results
            for classification in results {
                var identifier = classification.identifier
                identifier = identifier.prefix(1).capitalized + identifier.dropFirst()
                
                self.results.append(Result(imageLabel: identifier, confidence: Double(classification.confidence)))
            }
        }
        
        // Execute the request
        do{
            try handler.perform([request])
        }catch{
            print("Invalid image")
        }
    }
}

