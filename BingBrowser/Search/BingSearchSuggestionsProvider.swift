//
//  BingSearchSuggestionsProvider.swift
//  BingBrowser
//
//  Created by Mark Schall on 4/4/24.
//

import Foundation

class BingSearchSuggestionsProvider {
    
    func searchSuggestsionsDataTask(with query: String, completionHandler: @escaping ([String]) -> Void) -> URLSessionDataTask? {
       return URLSession.shared.searchSuggestionDataTask(with: query) { data, response, error in
            if let data = data,
               let string = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    completionHandler(string.parseSuggestions())
                }
            }
        }
    }
    
}

extension URLSession {
    func searchSuggestionDataTask(with query: String, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
        var components = URLComponents(string: "https://api.bing.com/osjson.aspx")!
        components.queryItems = [URLQueryItem(name: "q", value: query)]
        if let url = components.url {
            return URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: completionHandler)
        }
        
        return nil
    }
}

extension String {
    /// Example
    /// ["firefox",["firefox","firefox download","firefox mozilla","firefox browser","firefox download for pc","firefox for windows 10","firefox esr","firefox nightly","firefox focus","firefox apk","firefox portable","firefox download for windows 10","firefox download for windows 11","firefox developer edition","firefox app","firefox browser download","firefox extensions","firefox installer","firefox windows 11","firefox free download windows 10","firefox windows 7","firefox mozilla download","firefox web developer","firefox offline installer","firefox quantum download 64 bit"],[],[],{"google:suggestrelevance":[1300,1299,1298,1297,1296,1295,1294,1293,1292,1291,1290,1289,1288,1287,1286,1285,1284,1283,1282,1281,1280,1279,1278,1277,1276]}]
    
    
    func parseSuggestions() -> [String] {
        var suggestions: [String] = []
        
        let regex = /,\[(.*?)\]/
        
        if let match = firstMatch(of: regex) {
            let suggestionString = match.output.1
            let commaSeparatedSuggestions = suggestionString.replacing("\"", with: "")
            suggestions = commaSeparatedSuggestions.split(separator: ",").map({String($0)})
        }
        
        return suggestions
    }
}
