//
//  BingWebView.swift
//  BingBrowser
//
//  Created by Mark Schall on 4/4/24.
//

import WebKit

class BingWebView: WKWebView {
    
    func search(query: String) {
        
        var components = URLComponents(string: "https://www.bing.com/search")!
        components.queryItems = [URLQueryItem(name: "q", value: query)]
        
        if let url = components.url {
            load(URLRequest(url: url))
        }
    }
    
    
}
