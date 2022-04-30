//
//  HomeViewController.swift
//  My Netflix Clone
//
//  Created by said fatah on 21/4/2022.
//

import UIKit

enum sections:Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case UpcomingMovies = 2
    case Popular = 3
    case TopRatedMovies = 4
}

class HomeViewController: UIViewController {
    let sectionTitles:[String] = ["Trending Movies","Popular","Trending Tv","Upcoming movies","Top rated "]
    var homeFeedTableView :UITableView = {
        var _tableView = UITableView(frame: .zero, style: .grouped)
        _tableView.backgroundColor = .systemBackground
        _tableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)

        return _tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(homeFeedTableView)
        homeFeedTableView.dataSource = self
        homeFeedTableView.delegate = self
        
        configureNvbar()
        
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 400))
        homeFeedTableView.tableHeaderView = headerView
    }
    
    private func configureNvbar(){
        
       // left bar button [logo]
       let netflixLogoUIViewContainer = UIView(frame: CGRect.init(x: 0, y: 0, width: 25, height: 30))
        
       let netflixLogo = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 25, height: 30))
       netflixLogo.image = UIImage(named: "Netflix_Logo")
        
       netflixLogoUIViewContainer.addSubview(netflixLogo)
        
       let searchBarButtonItem = UIBarButtonItem(customView: netflixLogoUIViewContainer)
       searchBarButtonItem.width = 20
       navigationItem.leftBarButtonItem = searchBarButtonItem
        
       // right bar buttons
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil),
        ]
        navigationController?.navigationBar.tintColor = .red
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTableView.frame = view.bounds
    }

  
}

extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitles.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as? CollectionTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        switch indexPath.section {
        case sections.Popular.rawValue :
            ApiCaller.shared.getPopularMovies{ results in
                switch results{
                case .success(let popularMovies):
                    cell.configure(with: popularMovies)
                case .failure(let error):
                    print(error )

                }
            }
        case sections.TrendingTv.rawValue:
            ApiCaller.shared.getTrendingTv { results in
                switch results{
                case .success(let trendingTvShows):
                    cell.configure(with:trendingTvShows)
                case .failure(let error):
                    print(error )

                }
            }
        case sections.TrendingMovies.rawValue:
            ApiCaller.shared.getTrendingMovies { results in
                switch results{
                case .success(let trendingMovies):
                    cell.configure(with:trendingMovies)
                case .failure(let error):
                    print(error )

                }
            }
        case sections.UpcomingMovies.rawValue:
            ApiCaller.shared.getUpcomingMovies{ results in
                switch results{
                case .success(let upcomingMovies):
                    cell.configure(with:upcomingMovies)
                case .failure(let error):
                    print(error )

                }
            }
        case sections.TopRatedMovies.rawValue:
            ApiCaller.shared.getTopRatedMovies{ results in
                switch results{
                case .success(let topRatedMovies):
                    cell.configure(with:topRatedMovies)
                case .failure(let error):
                    print(error )

                }
            }
 
          
        default:
             return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20 , y: header.bounds.origin.y, width: 100, height: header.bounds.height )
        header.textLabel?.text = header.textLabel?.text?.capitalized
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y:min(0, -offset))
    }
    
   
}

extension HomeViewController :CollectionTableViewCellDelegate{
    func collectionTableViewCellDelegateDidTapCell(_ cell: CollectionTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
}
