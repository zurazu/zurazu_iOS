//
//  ImageService.swift
//  ZURAZU
//
//  Created by itzel.du on 2021/06/19.
//

import UIKit

struct ImageService {
  
  static let memoryCache = NSCache<NSString, UIImage>()
  
  func loadImage(by urlString: String, completionHandler: @escaping (UIImage?) -> Void) {
    if let cachedImage = ImageService.memoryCache.object(forKey: urlString as NSString) {
      completionHandler(cachedImage)
      return
    }
    
    guard let url = URL(string: urlString),
          let data = try? Data(contentsOf: url, options: .uncached),
          let image = UIImage(data: data)
    else { completionHandler(nil); return }
    
    ImageService.memoryCache.setObject(image, forKey: urlString as NSString)
    completionHandler(image)
  }
}
