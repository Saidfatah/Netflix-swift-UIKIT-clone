//
//  SearchViewController.swift
//  My Netflix Clone
//
//  Created by said fatah on 21/4/2022.
//

import UIKit

class SearchViewController: UIViewController {

    var titlesSearchResults:[Title] = [Title]()
    var searchFeedTableView :UITableView = {
        var tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .systemBackground
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var searchMoviesUITextField :LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        let borderColor = UIColor.gray
        textField.layer.borderColor = borderColor.cgColor
        textField.layer.borderWidth =  1.0
        textField.layer.cornerRadius = 5
        textField.backgroundColor = .white
        textField.returnKeyType = .search
        //make keyboord to appear when the screen firet loads
        textField.becomeFirstResponder()

        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(searchMoviesUITextField)
        view.addSubview(searchFeedTableView)
    
        
        searchMoviesUITextField.delegate = self
        searchFeedTableView.delegate = self
        searchFeedTableView.dataSource = self
    }
    
    private func setupConstraints(){
        let searchMoviesUITextFieldConstraints:[NSLayoutConstraint] = [
            searchMoviesUITextField.heightAnchor.constraint(equalToConstant: 50),
            searchMoviesUITextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 25),
            searchMoviesUITextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -25),
            searchMoviesUITextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ]
        let searchFeedTableViewConstraints:[NSLayoutConstraint] = [
            searchFeedTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            searchFeedTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchFeedTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchFeedTableView.topAnchor.constraint(equalTo: searchMoviesUITextField.bottomAnchor,constant: 25),
            searchFeedTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(searchFeedTableViewConstraints)
        NSLayoutConstraint.activate(searchMoviesUITextFieldConstraints)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }
    

}

extension SearchViewController :UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchMoviesUITextField.resignFirstResponder()
        let query = searchMoviesUITextField.text?.trimingLeadingSpaces().trimingTrailingSpaces()
        // only perform search if text is not empty string
        if(query != ""){
            // start spinner animations
            let spinner: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: searchFeedTableView.bounds.width, height: CGFloat(120))
            self.searchFeedTableView.tableFooterView = spinner
            self.searchFeedTableView.tableFooterView?.isHidden = false
            
            
            
            ApiCaller.shared.getSearchedMovies(searchFor: query ?? "movie title") {[weak self] results in
                switch results{
                case .success(let moviesSearchResults):
                    if(moviesSearchResults.count > 0){
                        self?.titlesSearchResults = moviesSearchResults
                        DispatchQueue.main.async {
                            self?.searchFeedTableView.tableFooterView?.isHidden = true
                            self?.searchFeedTableView.reloadData()
                        }

                    }else {
                        let noResultsLabel = UILabel()
                        noResultsLabel.text = "Opps No Results !"
                        noResultsLabel.font = .boldSystemFont(ofSize: 24)
                        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self?.searchFeedTableView.bounds.width ?? 200, height: CGFloat(120))
                        self?.searchFeedTableView.tableFooterView = noResultsLabel
                    }
                                    case .failure(let error):
                    print(error )

                }
            }
        }
      
        return true
    }
}

extension SearchViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titlesSearchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else { return UITableViewCell()}
        let title = titlesSearchResults[indexPath.row]

        let name = title.original_name ?? title.title   ?? "default value"
        guard let poster_path = title.poster_path else { return UITableViewCell() }
            

        
        let titleviewModel = TitleViewModel(titleName: name, posterUrl: poster_path)
        cell.configureTitleCell(with: titleviewModel)
        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
  
}

