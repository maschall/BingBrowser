# BingBrowser

This project is an implementation of UISearchController, to show suggestions and search using Bing.

Ultimately there are three files of interests:

[BingSearchWebViewController](https://github.com/maschall/BingBrowser/blob/main/BingBrowser/Search/BingSearchWebViewController.swift) - This class maintains the interaction between handling the search bar interactions and the Searcher.

[BingSearchSuggestionsProvider](https://github.com/maschall/BingBrowser/blob/main/BingBrowser/Search/BingSearchSuggestionsProvider.swift) - This class/file has the logic for getting search suggestions from Bing's API and returning an array of suggestions.

[BingWebView](https://github.com/maschall/BingBrowser/blob/main/BingBrowser/Search/BingWebView.swift) - This class wraps WKWebView to get a helper method to convert a search query into a search browse.


## Scene Delegate

When the app launches and the scene delegate is called, we show a Navigation Controller with the BingSearchWebViewController as the root view.  This allows us to set the Search Controller on the `navigationItem` and get some useful functionality done.

## Possible Improvements

The parsing of the response from Bing, is less than ideal, and so is the format.  It's possible in the future we need more of the information in the response and need to change the implementation.

If in the future we want to expand to add more search providers like Google and DuckDuckGo, we could abstract the suggestions and web view classes to swap in and out different results without repeating the search logic.

It's most likely we will want a more custom looking search bar.  It would probably make more sense to implement our own version of a UISearchController with custom views for UISearchBar, however to not spend too much time in this project, we can use some of the built in functionality.  Additionally, the means of canceling the last search suggestions while someone might be typing, is not as ideal than a traditional debouncing, since the network call may still be made and take up resources.
