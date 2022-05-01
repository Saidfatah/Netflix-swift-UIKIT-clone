//
//  CollectionTableViewCell.swift
//  My Netflix Clone
//
//  Created by said fatah on 22/4/2022.
//


import UIKit

protocol CollectionTableViewCellDelegate:AnyObject {
    func collectionTableViewCellDelegateDidTapCell(_ cell:CollectionTableViewCell , viewModel : TitlePreviewViewModel)
}

class CollectionTableViewCell: UITableViewCell {
    
    weak var delegate:CollectionTableViewCellDelegate?
    static let identifier = "collection-view-table-cell"
    private var titles :[Title] = [Title]()
    private let collectionView:UICollectionView = {
        let layout = SnappingCollectionViewLayout_()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        let collectionView = UICollectionView(frame: .zero , collectionViewLayout: layout)
        collectionView.register(ThumbnailCollectionViewCell.self, forCellWithReuseIdentifier: ThumbnailCollectionViewCell.identifier)
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:ThumbnailCollectionViewCell.identifier, for: indexPath) as? ThumbnailCollectionViewCell else {return UICollectionViewCell() }
        
        
        guard let poster_path = titles[indexPath.row].poster_path else {return  UICollectionViewCell()}
        
        cell.configureThumbnail(with: poster_path )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let title_name =  titles[indexPath.row].title ??  titles[indexPath.row].original_name  else {return  }
        print("click didSelectItemAt")
        ApiCaller.shared.getYoutubeTrailer(searchFor: title_name + "trailer") {[weak self] results in
            DispatchQueue.main.async {
                switch results {
                case .success(let youtubeVideo):
                    let title = self?.titles[indexPath.row]
                    guard let strongSelf = self  else {return}
                    let viewModel = TitlePreviewViewModel(title: title_name, youtubeVideo: youtubeVideo , overview: title?.overview ?? "overview ")
                    self?.delegate?.collectionTableViewCellDelegateDidTapCell(strongSelf, viewModel: viewModel)
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }
    }
    
}
