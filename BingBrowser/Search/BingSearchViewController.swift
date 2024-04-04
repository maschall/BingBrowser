//
//  BingSearchViewController.swift
//  BingBrowser
//
//  Created by Mark Schall on 4/3/24.
//

import UIKit

class BingSearchViewController: UISearchController {
    
    init() {
        let searchResults = BingSearchWebViewController()
        super.init(searchResultsController: searchResults)
        self.searchResultsUpdater = searchResults
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.searchController = self
        definesPresentationContext = true
        searchBar.placeholder = "Search Bing"
    }
    
//    let searchController = UISearchController()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        guard let view = view else { return }
//        
//        view.backgroundColor = .white
//        
//        let searchBar = BingSearchBar()
//        searchBar.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(searchBar)
//        
//        let searchResults = BingSearchWebView()
//        searchResults.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(searchResults)
//        searchController.searchResultsUpdater = searchResults
//        searchController.searchResultsController = searchResults
//        
//        view.translatesAutoresizingMaskIntoConstraints = false
//        let guide = view.safeAreaLayoutGuide
//        view.addConstraints([
//            searchBar.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1),
//            searchBar.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
//            searchBar.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
//            
//            searchBar.bottomAnchor.constraint(equalTo: searchResults.topAnchor),
//            
//            searchResults.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
//            searchResults.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
//            searchResults.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
//        ])
//    }
    
}

