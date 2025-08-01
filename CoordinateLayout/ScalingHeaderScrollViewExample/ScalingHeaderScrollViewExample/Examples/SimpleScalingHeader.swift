//
//  SimpleScalingHeader.swift
//  Example
//
//  Created by Daniil Manin on 28.09.2021.
//  Copyright © 2021 Exyte. All rights reserved.
//

import SwiftUI
import ISwiftUIKit_CoordinateLayout

struct SimpleScalingHeader: View {

    @Environment(\.presentationMode) var presentationMode

    @State private var selectedImage: String = "image_1"
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ScalingHeaderScrollView {
                Image(selectedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            } content: {
                Text(defaultDescription)
                    .padding()
            }
            .pullToRefresh() {
                changeImage()
            }
            .allowsHeaderCollapse()
            .ignoresSafeArea()

            Button("", action: { self.presentationMode.wrappedValue.dismiss() })
                .buttonStyle(CircleButtonStyle(imageName: "arrow.backward"))
                .padding(.leading, 16)
        }
    }
    
    // MARK: - Private
    
    private func changeImage() {
        selectedImage = selectedImage == "image_1" ? "image_2" : "image_1"
    }
}
