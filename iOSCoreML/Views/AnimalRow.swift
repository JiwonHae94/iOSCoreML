//
//  AnimalRowView.swift
//  iOSCoreML
//
//  Created by Jiwon_Hae on 2021/12/13.
//

import SwiftUI

struct AnimalRow: View {
    var imageLabel : String
    var confidence : Double
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .cornerRadius(10)
                .shadow(color: .gray, radius: 5, x: 0, y:5)
            
            
            VStack{
                HStack{
                    Text(imageLabel)
                        .foregroundColor(.black)
                    Spacer()
                    Text(String(format:"%.2f%%", confidence * 100))
                        .foregroundColor(.black)
                }
                
                ProgressBar(value: confidence)
                    .frame(height: 10)
            }
            .padding(10)
        }
    }
}

struct AnimalRowView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalRow(imageLabel: "husky", confidence: 23)
    }
}
