//
//  MockImageDataFetcher.swift
//  PictureGenTests
//
//  Created by Вадим Гамзаев on 09.05.2023.
//

import Foundation
@testable import PictureGen

class MockImageDataFetcher: IImageDataFetcher {
	private let succes: Result<Data, Error> = .success(Data())
	private let failure: Result<Data, Error> = .failure(ImageFetcherError.dataNotFound)
	
	func fetchImageData(from text: String, completion: @escaping (Result<Data, Error>) -> Void) {
		if text == "succes" {
			completion(succes)
		} else {
			completion(failure)
		}
	}
}
