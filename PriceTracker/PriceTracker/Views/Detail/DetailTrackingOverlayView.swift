//
//  DetailTrackingOverlayView.swift
//  PriceTracker
//
//  Created by seobyeonggwan on 2024/12/06.
//

import SwiftUI

struct DetailTrackingOverlayView: View {
    @Binding var inputPrice: String
    var onCancel: () -> Void
    var onOK: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()

            VStack {
                Text(LocalizedStringKey("price_input_string"))
                    .font(.headline)
                    .padding()
                TextField(LocalizedStringKey("price_input_placeholder_string"), text: $inputPrice)
                    .keyboardType(.decimalPad)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                HStack {
                    Button(LocalizedStringKey("cancel_button")) {
                        onCancel()
                    }
                    .padding()

                    Spacer()

                    Button(LocalizedStringKey("ok_button")) {
                        onOK()
                    }
                    .padding()
                }
                .padding()
            }
            .frame(maxWidth: 400, maxHeight: 300)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
        }
    }
}
