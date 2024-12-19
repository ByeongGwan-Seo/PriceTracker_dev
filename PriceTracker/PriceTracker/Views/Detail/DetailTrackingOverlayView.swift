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
                Text(L10n.priceInputString)
                    .font(.headline)
                    .padding()
                TextField(L10n.priceInputPlaceholderString, text: $inputPrice)
                    .keyboardType(.decimalPad)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                HStack {
                    Button(L10n.cancelButton) {
                        onCancel()
                    }
                    .padding()

                    Spacer()

                    Button(L10n.okButton) {
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
