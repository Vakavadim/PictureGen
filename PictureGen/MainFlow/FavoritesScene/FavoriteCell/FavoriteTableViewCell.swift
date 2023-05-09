//
//  FavoriteTableViewCell.swift
//  PictureGen
//
//  Created by Вадим Гамзаев on 09.05.2023.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
	
	// MARK: - Internal properties
	
	static let reuseIdentifier = "FavoriteTableViewCell"
	
	// MARK: - Private properties
	
	private lazy var  pictureImageView: UIImageView = makeImageView()
	private lazy var  label: UILabel = makeLabel()
	
	// MARK: - Lifecycle
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		addSubview(pictureImageView)
		addSubview(label)
		
		NSLayoutConstraint.activate([
			pictureImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			pictureImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
			pictureImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
			pictureImageView.widthAnchor.constraint(equalTo: pictureImageView.heightAnchor),
			
			label.leadingAnchor.constraint(equalTo: pictureImageView.trailingAnchor, constant: 16),
			label.topAnchor.constraint(equalTo: topAnchor, constant: 16),
			label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Internal methods
	func configureCell(withImage image: UIImage, text: String) {
		pictureImageView.image = image
		label.text = text
	}

	// MARK: - Private methods
	
	private func makeImageView() -> UIImageView {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		return imageView
	}
	
	private func makeLabel() -> UILabel {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 16)
		label.numberOfLines = 0
		return label
	}
}
