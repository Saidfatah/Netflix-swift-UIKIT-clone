//
//  ThumbnailCollectionViewCell.swift
//  My Netflix Clone
//
//  Created by said fatah on 23/4/2022.
//

import UIKit
import SDWebImage

class ThumbnailCollectionViewCell: UICollectionViewCell {
    static let indentifier = "ThumbnailCollectionViewCell"
    
    private let thumbnailImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(thumbnailImageView)
    }
    
    required init?(coder : NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        thumbnailImageView.frame = contentView.bounds
    }
    public func configureThumbnail(with model:String){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else {return }
        thumbnailImageView.sd_setImage(with: url,completed: nil)
    }
}
