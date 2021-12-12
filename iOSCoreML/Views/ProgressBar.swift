//
//  ProgressBarView.swift
//  iOSCoreML
//
//  Created by Jiwon_Hae on 2021/12/13.
//

import SwiftUI

struct ProgressBar: View {
    var value : Double
    var meterColor : Color {
        if value > 0.7{
            return .green
        }
        else if value > 0.5 {
            return .yellow
        }
        else if value > 0.3{
            return .orange
        } else {
            return .red
        }
    }
    
    var body: some View {
        GeometryReader{ geo in
            ZStack(alignment: .leading){
                Rectangle()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .opacity(0.3)
                    .foregroundColor(.gray)
                
                Rectangle()
                    .frame(width: geo.size.width * CGFloat(self.value), height: geo.size.height)
                    .foregroundColor(meterColor)
            }
        }
        .cornerRadius(45)
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(value : 0.7)
            .previewLayout(.fixed(width: 300, height: 10))
    }
}
