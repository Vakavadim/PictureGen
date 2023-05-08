//
//  SearchModels.swift
//  PictureGen
//
//  Created by Вадим Гамзаев on 07.05.2023.
//

import UIKit

enum SearchModel {
	struct Request {
		let searchTerm: String
	}
	enum Response {
		case success(PictureData)
		case failure(ImageFetcherError)
		
		struct PictureData {
			let imageData: Data
			let searchTerm: String
		}
	}
	enum ViewModel {
		case success(Picture)
		case failure(String)
		
		struct Picture {
			let image: UIImage
			let searchTerm: String
		}
	}
}
