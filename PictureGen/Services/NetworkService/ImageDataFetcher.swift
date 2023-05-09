//
//  NetworkService.swift
//  PictureGen
//
//  Created by Вадим Гамзаев on 08.05.2023.
//

import Foundation
import SystemConfiguration

enum ImageFetcherError: Error {
	case invalidUrl
	case dataNotFound
	case noInternetConnection
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
		
		if !isConnectedToNetwork() {
			completion(.failure(ImageFetcherError.noInternetConnection))
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
	
	private func isConnectedToNetwork() -> Bool {
		var zeroAddress = sockaddr_in()
		zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
		zeroAddress.sin_family = sa_family_t(AF_INET)
		
		guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
			$0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
				SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
			}
		}) else {
			return false
		}
		
		var flags: SCNetworkReachabilityFlags = []
		if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
			return false
		}
		if flags.contains(.reachable) == false {
			return false
		}
		if flags.contains(.isWWAN) {
			return true
		}
		if flags.contains(.connectionRequired) == false {
			return true
		}
		if flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic) {
			if flags.contains(.interventionRequired) == false {
				return true
			}
		}
		return false
	}
}
