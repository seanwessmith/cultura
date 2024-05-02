//
//  ImageAnalyzer.swift
//  cultura
//
//  Created by Sean Smith on 4/30/24.
//

import SwiftUI
import Foundation

class ImageAnalyzer {
    static func analyzeImage(image: UIImage, completion: @escaping (String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion("Failed to prepare image")
            return
        }
        let base64Image = imageData.base64EncodedString()

        // Assuming using a placeholder URL and API key
        let urlString = "https://api.example.com/analyze"
        let apiKey = "YOUR_API_KEY"
        
        guard let url = URL(string: urlString) else {
            completion("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        let body: [String: Any] = ["image": base64Image]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion("Network error: \(error?.localizedDescription ?? "No error info")")
                return
            }

            let responseString = String(data: data, encoding: .utf8) ?? "Failed to decode response"
            completion(responseString)
        }.resume()
    }
}
