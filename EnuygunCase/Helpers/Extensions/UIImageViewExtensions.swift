//
//  UIImageViewExtensions.swift
//  EnuygunCase
//
//  Created by Tolga Taş on 24.02.2024.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL) {
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                return
            }
            
            if let imageData = data {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
        dataTask.resume()
    }
}
