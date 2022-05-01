//
//  HeroHeaderUIView.swift
//  My Netflix Clone
//
//  Created by said fatah on 22/4/2022.
//

import UIKit

class HeroHeaderUIView: UIView {
    private let playButton :PrimaryUIButton = {
        var button = PrimaryUIButton()
        button.setTitle("Play", for:.normal)
        return button
        
    }()
    private let downloadButton :PrimaryUIButton = {
        var button = PrimaryUIButton()
        button.setTitle("Download", for:.normal)
        return button
        
    }()
    /// for adding the hero image
    private let heroImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        // avoid overflow
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "batman")
        return imageView
    }()
    
    private func addGradiant(){
        
        let gradiantLayer = CAGradientLayer()
        gradiantLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradiantLayer.frame = bounds
        layer.addSublayer(gradiantLayer)
    }
   
 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradiant()
        addButtonsView()
        
    }
    
    private func addButtonsView(){
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonsView)
        let buttonsViewConstraints:[NSLayoutConstraint] = [
            buttonsView.widthAnchor.constraint(equalTo: widthAnchor),
            buttonsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonsView.heightAnchor.constraint(equalToConstant: 100),
            buttonsView.bottomAnchor.constraint(equalTo: bottomAnchor ,constant: -25),
        ]
        NSLayoutConstraint.activate(buttonsViewConstraints)
        
        buttonsView.addSubview(playButton)
        buttonsView.addSubview(downloadButton)
        
        let playButtonConstraints:[NSLayoutConstraint] = [
            playButton.leadingAnchor.constraint(equalTo: buttonsView.leadingAnchor ,constant: 60),
            playButton.bottomAnchor.constraint(equalTo: buttonsView.bottomAnchor),
            playButton.widthAnchor.constraint(equalTo: buttonsView.widthAnchor, multiplier: 0.3),
        ]
         
        let downloadButtonConstraints:[NSLayoutConstraint] = [
            downloadButton.trailingAnchor.constraint(equalTo: buttonsView.trailingAnchor , constant: -60 ),
            downloadButton.bottomAnchor.constraint(equalTo: buttonsView.bottomAnchor),
            downloadButton.widthAnchor.constraint(equalTo: buttonsView.widthAnchor, multiplier: 0.3),
        ]

        
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure(with model:TitleViewModel){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterUrl)") else {return }
        heroImageView.sd_setImage(with: url,completed: nil)
        
    }
}
