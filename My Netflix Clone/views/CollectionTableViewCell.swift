//
//  CollectionTableViewCell.swift
//  My Netflix Clone
//
//  Created by said fatah on 22/4/2022.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    static let indentifier = "collection-view-table-cell"
    private var titles :[Title] = [Title]()
    private let collectionView:UICollectionView = {
        let layout = SnappingCollectionViewLayout_()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        let collectionView = UICollectionView(frame: .zero , collectionViewLayout: layout)
        collectionView.register(ThumbnailCollectionViewCell.self, forCellWithReuseIdentifier: ThumbnailCollectionViewCell.indentifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    public func configure(with titles: [Title] ){
        self.titles = titles
        DispatchQueue.main.async {[weak self] in
            // reload the collection vies to reflect the newly fetched titles
            self?.collectionView.reloadData()
        }
    }
}

extension CollectionTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        titles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:ThumbnailCollectionViewCell.indentifier, for: indexPath) as? ThumbnailCollectionViewCell else {return UICollectionViewCell() }
        
        
        guard let poster_path = titles[indexPath.row].poster_path else {return  UICollectionViewCell()}
        
        cell.configureThumbnail(with: poster_path )
        return cell
    }
}
