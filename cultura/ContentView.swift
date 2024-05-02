//
//  ContentView.swift
//  cultura
//
//  Created by Sean Smith on 4/30/24.
//

import SwiftUI

struct ContentView: View {
    @State private var image: UIImage?
    @State private var isImagePickerDisplayed = false
    @State private var analysisResult: String = "Capture an image to analyze"

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()

                Text(analysisResult)
                    .padding()
            }

            Button("Open Camera") {
                isImagePickerDisplayed = true
            }
        }
        .sheet(isPresented: $isImagePickerDisplayed) {
            ImagePicker(selectedImage: $image)
        }
        .onChange() { _ in
            guard let selectedImage = image else { return }
            ImageAnalyzer.analyzeImage(image: selectedImage) { result in
                DispatchQueue.main.async {
                    analysisResult = result
                }
            }
        }
    }
}
