//
//  Router.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/05/06.
//

import Foundation
import Combine
import UIKit

extension NSMutableData {
  func appendString(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}

final class NetworkProvider: NetworkProvidable {
  
  private let urlSession: URLSession
  
  init(urlSession: URLSession = URLSession.shared) {
    self.urlSession = urlSession
  }
  
  func request<T: Decodable>(route: EndPointable) -> AnyPublisher<Result<T, NetworkError>, Never> {
    guard let request: URLRequest = setupRequest(from: route) else {
      return .just(.failure(.client))
    }

    return urlSession.dataTaskPublisher(for: request)
      .mapError { _ in NetworkError.unknown }
      .flatMap { [weak self] data, response -> AnyPublisher<Data, Error> in
        guard let response: HTTPURLResponse = response as? HTTPURLResponse else {
          return .fail(NetworkError.server)
        }

        if let error: NetworkError = self?.handleNetworkResponseError(response) {
          return .fail(error)
        }
        
        return .just(data)
      }
      .decode(type: T.self, decoder: JSONDecoder())
      .map { .success($0) }
      .catch { _ -> AnyPublisher<Result<T, NetworkError>, Never> in
        return .just(.failure(.decodingJson))
      }
      .eraseToAnyPublisher()
  }
  
  func convertFormField(named name: String, value: String, using boundary: String) -> String {
    var fieldString = "--\(boundary)\r\n"
    fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
    fieldString += "\r\n"
    fieldString += "\(value)\r\n"

    return fieldString
  }

  func convertFileData(fieldName: String, fileName: String, mimeType: String, fileData: Data, using boundary: String) -> Data {
    let data = NSMutableData()
   
      data.appendString("--\(boundary)\r\n")
      data.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
      data.appendString("Content-Type: \(mimeType)\r\n\r\n")
      data.append(fileData)
      data.appendString("\r\n")


    return data as Data
  }

  func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
      let scale = newWidth / image.size.width // 새 이미지 확대/축소 비율
      let newHeight = image.size.height * scale
    UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
    image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
      let newImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
    return newImage ?? .add
  }
  
  func request<T: Decodable>(route: EndPointable, images: [UIImage]) -> AnyPublisher<Result<T, NetworkError>, Never> {
    guard var request: URLRequest = setupRequest(from: route) else {
      return .just(.failure(.client))
    }
    
    let formFields = ["name": "Dochoi"]

    let boundary = "Boundary-\(UUID().uuidString)"
  
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    
    let httpBody = NSMutableData()
    
    for (key, value) in formFields {
      httpBody.appendString(convertFormField(named: key, value: value, using: boundary))
    }

    images.enumerated().forEach { (index, image) in
      
      let smallImage = resizeImage(image: image, newWidth: 1000)
      let imageData = smallImage.jpegData(compressionQuality: 0)!
    httpBody.append(convertFileData(fieldName: "image_field\(index)",
                            fileName: "\(Date())image\(index).jpeg",
                            mimeType: "multipart/form-data",
                            fileData: imageData,
                            using: boundary))
    }

    
    httpBody.appendString("--\(boundary)--")

    request.httpBody = httpBody as Data


    return urlSession.dataTaskPublisher(for: request)
      .mapError { _ in
        print("???")
        return NetworkError.unknown

      }
      .print()
      .flatMap { [weak self] data, response -> AnyPublisher<Data, Error> in
        guard let response: HTTPURLResponse = response as? HTTPURLResponse else {
          return .fail(NetworkError.server)
        }
        print(response)
        if let error: NetworkError = self?.handleNetworkResponseError(response) {
          return .fail(error)
        }
        
        return .just(data)
      }
      .decode(type: T.self, decoder: JSONDecoder())
      .map { .success($0) }
      .catch { _ -> AnyPublisher<Result<T, NetworkError>, Never> in
        return .just(.failure(.decodingJson))
      }
      .eraseToAnyPublisher()
  }
}
