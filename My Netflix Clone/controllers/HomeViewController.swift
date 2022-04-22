//
//  HomeViewController.swift
//  My Netflix Clone
//
//  Created by said fatah on 21/4/2022.
//

import UIKit

class HomeViewController: UIViewController {
    var homeFeedTableView :UITableView = {
        var _tableView = UITableView(frame: .zero, style: .grouped)
        _tableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.indentifier)

        return _tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTableView)
        homeFeedTableView.dataSource = self
        homeFeedTableView.delegate = self
        homeFeedTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 400))
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTableView.frame = view.bounds
    }

}

extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        20
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.indentifier, for: indexPath) as? CollectionTableViewCell else {
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
    
}
