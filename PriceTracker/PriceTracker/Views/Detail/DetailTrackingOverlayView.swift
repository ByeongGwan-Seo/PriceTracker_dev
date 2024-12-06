//
//  DetailTrackingOverlayView.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/12/06.
//

import SwiftUI

struct DetailTrackingOverlayView: View {
    @Binding var showTrackingAlert: Bool
    @Binding var inputPrice: String
    var onCancel: () -> Void
    var onOK: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(showTrackingAlert ? 0.4 : 0)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Enter Price")
                    .font(.headline)
                    .padding()
                
                TextField("Enter your target price", text: $inputPrice)
                    .keyboardType(.decimalPad)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                HStack {
                    Button("Cancel") {
                        onCancel()
                    }
                    .padding()
                    
                    Spacer()
                    
                    Button("OK") {
                        onOK()
                    }
                    .padding()
                }
                .padding()
            }
            .frame(maxWidth: 400, maxHeight: 300)
            .background(Color.white)
            .cornerRadius(10)
            .opacity(showTrackingAlert ? 1 : 0)
            .shadow(radius: 10)
            .padding()
        }
    }
}
