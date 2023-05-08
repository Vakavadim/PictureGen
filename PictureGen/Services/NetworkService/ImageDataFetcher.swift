//
//  NetworkService.swift
//  PictureGen
//
//  Created by Вадим Гамзаев on 08.05.2023.
//

import Foundation

enum ImageFetcherError: Error {
	case invalidUrl
	case dataNotFound
}

protocol IImageDataFetcher {
	func fetchImageData(from text: String, completion: @escaping (Result<Data, Error>) -> Void)
}

class ImageDataFetcher: IImageDataFetcher {
	
	// MARK: - Private properties
	
	private let baseUrl = URL(string: "https://dummyimage.com/500x500&text=")

	// MARK: - Public methods
	
	func fetchImageData(from text: String, completion: @escaping (Result<Data, Error>) -> Void) {
		guard let baseUrl = baseUrl else {
			completion(.failure(ImageFetcherError.invalidUrl))
			return
		}
		guard let url = URL(string: "\(baseUrl.absoluteString)\(text)") else {
			completion(.failure(ImageFetcherError.invalidUrl))
			return
		}
		
		URLSession.shared.dataTask(with: url) { data, response, error in
			if let error = error {
				completion(.failure(error))
				return
			}
			
			guard let httpResponse = response as? HTTPURLResponse,
				  200..<300 ~= httpResponse.statusCode,
				  let data = data else {
				completion(.failure(ImageFetcherError.dataNotFound))
				return
			}
			
			completion(.success(data))
		}
		.resume()
	}
}
