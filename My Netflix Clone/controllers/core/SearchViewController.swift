//
//  SearchViewController.swift
//  My Netflix Clone
//
//  Created by said fatah on 24/4/2022.
//

import UIKit

class SearchViewController: UIViewController {

    var titlesSearchResults:[Title] = [Title]()
 
//    private let discoverTableView :UITableView = {
//        var tableView = UITableView(frame: .zero, style: .grouped)
//        tableView.backgroundColor = .systemBackground
//        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        return tableView
//    }()
    private let searchController :UISearchController = {
        var search = UISearchController(searchResultsController: SearchResultsViewController())
        search.searchBar.placeholder = "search for a movie"
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.searchBarStyle = .minimal
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        // configure search controller
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .red
        
//        discoverTableView.delegate = self
//        discoverTableView.dataSource = self
    }
 
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//    }
//

}


extension SearchViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
        !query.trimmingCharacters(in: .whitespaces).isEmpty,
        query.trimmingCharacters(in: .whitespaces).count >= 3
        else { return}
        
        guard let resultsControler = searchController.searchResultsController as? SearchResultsViewController else {return}
        
        ApiCaller.shared.getSearchedMovies(searchFor: query) { reults in
            DispatchQueue.main.async {
                switch reults {
                case .success(let searchResults):
                    resultsControler.titles = searchResults
                    resultsControler.searchResultesCollectionView.reloadData()
                
                case .failure(let error):
                    print(error.localizedDescription)
                }
            
            }
        }
        
    }
}

//extension SearchViewController:UITableViewDelegate,UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return titlesSearchResults.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else { return UITableViewCell()}
//        let title = titlesSearchResults[indexPath.row]
//
//        let name = title.original_name ?? title.title   ?? "default value"
//        guard let poster_path = title.poster_path else { return UITableViewCell() }
//
//
//
//        let titleviewModel = TitleViewModel(titleName: name, posterUrl: poster_path)
//        cell.configureTitleCell(with: titleviewModel)
//        return cell
//    }
//
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        100
//    }
//
//
//}
//
