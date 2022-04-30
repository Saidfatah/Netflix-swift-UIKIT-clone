//
//  ViewController.swift
//  My Netflix Clone
//
//  Created by said fatah on 24/4/2022.
//

import UIKit

class SearchResultsViewController: UIViewController {
    public var titles:[Title] = [Title]()
    public let searchResultesCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ThumbnailCollectionViewCell.self, forCellWithReuseIdentifier: ThumbnailCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        // Do any additional setup after loading the view.
       
        view.backgroundColor = .systemBackground
        view.addSubview(searchResultesCollectionView)
        
        searchResultesCollectionView.delegate = self
        searchResultesCollectionView.dataSource = self
        
    }
 
    
    override func viewDidLayoutSubviews() {
        searchResultesCollectionView.frame = view.bounds
    }
 
}

extension SearchResultsViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailCollectionViewCell.identifier, for: indexPath) as? ThumbnailCollectionViewCell else {return UICollectionViewCell()}
        
        let title = titles[indexPath.row]
        cell.configureThumbnail(with: title.poster_path ?? "poster")
        return cell
    }
}
