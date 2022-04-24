//
//  UpcomingViewController.swift
//  My Netflix Clone
//
//  Created by said fatah on 21/4/2022.
//

import UIKit

class UpcomingViewController: UIViewController {
    private var titles:[Title] = [Title]()
    var upcomingFeedTableView :UITableView = {
        var _tableView = UITableView(frame: .zero, style: .grouped)
        _tableView.backgroundColor = .systemBackground
        _tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)

        return _tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.addSubview(upcomingFeedTableView)
        upcomingFeedTableView.delegate = self
        upcomingFeedTableView.dataSource = self
        fetchUpcomingMovies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingFeedTableView.frame = view.bounds
    }
    
    private func fetchUpcomingMovies(){
        ApiCaller.shared.getUpcomingMovies{[weak self] results in
            switch results{
            case .success(let upcomingMovies):
                self?.titles = upcomingMovies
                DispatchQueue.main.async {
                    self?.upcomingFeedTableView.reloadData()
                }
            case .failure(let error):
                print(error )

            }
        }
    }
}

extension UpcomingViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else { return UITableViewCell()}
        
        let title = titles[indexPath.row]
        let name = title.original_name ?? title.title ?? "nah"
        guard let poster_path = title.poster_path else { return UITableViewCell() }
        let titleviewModel = TitleViewModel(titleName: name, posterUrl: poster_path)
        cell.configureTitleCell(with: titleviewModel)
        
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }

    

}
