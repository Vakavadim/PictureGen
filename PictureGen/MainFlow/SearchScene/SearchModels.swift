//
//  SearchModels.swift
//  PictureGen
//
//  Created by Вадим Гамзаев on 07.05.2023.
//

import UIKit

enum SearchModel {
	enum Request {
		case getImageWithTerm(searchTerm: SearchTerm)
		case savePicture(picture: Picture)
		
		struct SearchTerm {
			let term: String
			var path: String {
				term.replacingOccurrences(of: " ", with: "+")
			}
		}
		struct Picture {
			let searchTerm: String
			let image: UIImage
		}
	}
	enum Response {
		case success(PictureData)
		case failure(Error)
		case save(String)
		
		struct PictureData {
			let imageData: Data
			let searchTerm: String
		}
	}
	enum ViewModel {
		case success(Picture)
		case failure(String)
		case saveMessage(String)
		
		struct Picture {
			let image: UIImage
			let searchTerm: String
		}
	}
}
