//
//  ArticleListViewModel.swift
//  NYTimesMostPopularArticles
//
//  Created by ANSAR on 29/11/21.
//

import Combine

class ArticlesDetailsViewModel: ObservableObject {
    @Published var heading:String
    @Published var name:String
    @Published var date:String
    @Published var image:String?
    @Published var detailImage:String?
    @Published var details:String?

    
    init(article: Article) {
         heading = article.title ?? ""
         name = article.byline  ?? ""
         date = article.published_date ?? ""
        details = article.abstract ?? ""
        image = article.media?.count ?? 0 > 0 ? article.media?.first?.media_metadata?.count ?? 0 > 0 ? article.media?.first?.media_metadata?.first?.url:"":""
        detailImage = article.media?.count ?? 0 > 0 ? article.media?.first?.media_metadata?.count ?? 0 > 0 ? article.media?.first?.media_metadata?.last?.url:"":""
    }
}
