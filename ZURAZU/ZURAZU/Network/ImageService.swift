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
    
    DispatchQueue.global().async {
      guard
        let url = URL(string: urlString),
        let downSmapledImage = downSampledImage(
          from: url,
          size: CGSize(width: 300, height: 300), scale: 1
        )
      else {
        completionHandler(nil)
        return
      }
      
      ImageService.memoryCache.setObject(downSmapledImage, forKey: urlString as NSString)
      
      DispatchQueue.main.async {
        completionHandler(downSmapledImage)
      }
      
    }
  }
  
  private func downSampledImage(
    from url: URL,
    size: CGSize,
    scale: CGFloat
  ) -> UIImage? {
    let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
    guard let imageSource = CGImageSourceCreateWithURL(url as CFURL, imageSourceOptions)
    else { return nil }
    
    let maxDimensionInPixels = max(size.width, size.height) * scale
    let downSamplingOptions = [
      kCGImageSourceCreateThumbnailFromImageAlways: true,
      kCGImageSourceShouldCacheImmediately: true,
      kCGImageSourceCreateThumbnailWithTransform: true,
      kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
    ] as CFDictionary
    
    guard let downSampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downSamplingOptions)
    else { return nil }
    
    return UIImage(cgImage: downSampledImage)
  }
}
