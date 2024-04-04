//
//  BingSearchWebViewController.swift
//  BingBrowser
//
//  Created by Mark Schall on 4/3/24.
//

import WebKit
import RegexBuilder

class BingSearchWebViewController: UIViewController {
    
    let webView = BingWebView()
    var searchSuggestionsProvider = BingSearchSuggestionsProvider()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Bing"
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self
        searchController.automaticallyShowsCancelButton = false
        searchController.hidesNavigationBarDuringPresentation = false
        return searchController
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        view.backgroundColor = .systemBackground
        
        webView.backgroundColor = .systemBackground
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        clearSearch()
    }
    
    func search(_ searchText: String?) {
        guard let searchText = searchText, !searchText.isEmpty else { clearSearch(); return }
        
        if searchController.searchBar.isFirstResponder {
            loadSearchSuggestions(searchText)
        } else {
            loadSearch(searchText)
        }
    }
    
    func loadSearch(_ searchText: String) {
        clearSearchSuggestions()
        webView.isHidden = false
        webView.search(query: searchText)
    }
    
    var currentDataTask: URLSessionDataTask?
    
    func loadSearchSuggestions(_ searchText: String) {
        let dataTask = searchSuggestionsProvider.searchSuggestsionsDataTask(with: searchText) { [weak self] suggestions in
            self?.searchController.searchSuggestions = suggestions.map { UISearchSuggestionItem(localizedSuggestion: $0) }
        }
        
        if let dataTask = dataTask {
            currentDataTask?.cancel()
            currentDataTask = dataTask
            dataTask.resume()
        }
    }
    
    func parseSuggestions(_ response: String) -> [String]? {
        return nil
    }
    
    func clearSearch() {
        webView.isHidden = true
        clearSearchSuggestions()
    }
    
    func clearSearchSuggestions() {
        searchController.searchSuggestions = nil
    }
    
}

extension BingSearchWebViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        search(searchController.searchBar.text)
    }
    
    func updateSearchResults(for searchController: UISearchController, selecting searchSuggestion: UISearchSuggestion) {
        searchController.searchBar.resignFirstResponder()
        searchController.searchBar.text = searchSuggestion.localizedSuggestion
    }
}

extension BingSearchWebViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.resignFirstResponder()
        search(searchBar.text)
    }
}

