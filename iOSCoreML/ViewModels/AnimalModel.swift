//
//  AnimalModel.swift
//  iOSCoreML
//
//  Created by Jiwon_Hae on 2021/12/13.
//

import Foundation

class AnimalModel : ObservableObject{
    @Published var animal = Animal()
    
    func getAnimal(){
        let stringURL = Bool.random() ? catURL : dogURL
        
        // Create a URL object
        let url = URL(string: stringURL)
        
        // Check that the URL isn't a nil
        guard url != nil else{
            print("Couln't create URL object")
            return
        }
        
        // Get a URL session
        let session = URLSession.shared
        
        // Create a data task
        let dataTask = session.dataTask(with: url!) { data, response, error in
        
            // If there is no error, and data was returned
            if error == nil && data != nil{
                
                // Attemp to parse JSON
                do{
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: Any]]{
                            
                        let item = json.isEmpty ? [:] : json[0]
                        
                        if let animal = Animal(json: item){
                            DispatchQueue.main.async {
                                
                                while animal.imageData == nil {}
                                self.animal = animal
                            }
                        }
                    }
                }catch{
                    print("Couldn't parse JSON")
                }
            }
        }
        
        // Start the data task
        dataTask.resume()
    }
    
}
