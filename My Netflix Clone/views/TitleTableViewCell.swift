//
//  TitleTableViewCell.swift
//  My Netflix Clone
//
//  Created by said fatah on 24/4/2022.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    static let identifier = "TitleTableViewCell"
    
    private let titlePosterUIImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30)), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .red
        
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titlePosterUIImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playButton)
        setUpConstraints()
    }
    
    private func setUpConstraints(){
        let titleImagelConstraints: [NSLayoutConstraint] = [
            titlePosterUIImageView.widthAnchor.constraint(equalToConstant: 100),
            titlePosterUIImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            titlePosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlePosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            titlePosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]

        let titleLabelConstraints: [NSLayoutConstraint] = [
            titleLabel.leadingAnchor.constraint(equalTo: titlePosterUIImageView.trailingAnchor,constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 200)
        ]
        let playButtonConstraints = [
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
 
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(titleImagelConstraints)
        NSLayoutConstraint.activate(playButtonConstraints)
    }
    
    public func configureTitleCell(with model:TitleViewModel){
        print(model.posterUrl)
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterUrl)") else {return }
        titlePosterUIImageView.sd_setImage(with: url,completed: nil)
        titleLabel.text = model.titleName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
