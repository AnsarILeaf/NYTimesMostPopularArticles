//
//  ArticleListViewModel.swift
//  NYTimesMostPopularArticles
//
//  Created by ANSAR on 29/11/21.
//

import Combine
import Foundation


class ArticlesViewModel: ObservableObject {
    
    @Published var articleList : Articles
    @Published var loading = false
    @Published var period = Periods.Week
    
    let service: ServiceProtocol
    init(service: ServiceProtocol = APIService()) {
        self.articleList = []
        self.service = service
    }
    
    func loadData() {
        self.loading = true
        service.fetchArticleList(periods: period, completion: {  articles in
            self.loading = false
            guard let articles = articles else {
                return
            }
            self.articleList = articles
        })
    }
}
