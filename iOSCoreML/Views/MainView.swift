//
//  MainView.swift
//  iOSCoreML
//
//  Created by Jiwon_Hae on 2021/12/13.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var model : AnimalModel
    
    var body: some View {
        VStack{
            Image(uiImage: UIImage(data: model.animal.imageData ?? Data()) ?? UIImage())
                .resizable()
                .scaledToFit()
                .clipped()
                .edgesIgnoringSafeArea(.all)
            
            HStack{
                Text("What is it?")
                    .font(.title)
                    .bold()
                    .padding(.leading, 10)
                
                Spacer()
                
                Button {
                    self.model.getAnimal()
                } label: {
                    Text("Next")
                        .bold()
                }

            }
        }
        .onAppear(perform: model.getAnimal)
        .opacity(model.animal.imageData == nil ? 0 : 1)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(AnimalModel())
    }
}
