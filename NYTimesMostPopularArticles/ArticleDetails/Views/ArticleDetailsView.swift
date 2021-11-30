//
//  ArticleDetailsView.swift
//  NYTimesMostPopularArticles
//
//  Created by ANSAR on 29/11/21.
//

import SwiftUI

struct ArticleDetails : View {
    @ObservedObject var viewModel : ArticlesDetailsViewModel

    init(article:Article) {
        viewModel = ArticlesDetailsViewModel(article: article)
    }
        
    var body: some View {
      
        ScrollView {
        VStack {
            UrlImageView(urlString: viewModel.detailImage).padding(EdgeInsets.init(top: 5, leading: 0, bottom: 0, trailing: 0))
                VStack(alignment: HorizontalAlignment.leading, spacing: 5) {
                    Text(viewModel.heading).styledText(semanticFont: .subHeading).padding(EdgeInsets.init(top: 5, leading: 0, bottom: 0, trailing: 10))
                    HStack {  Text(viewModel.name).styledText(semanticFont: .description).padding(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 10))
                    DateView(date: viewModel.date)
                    }
                    Text(viewModel.details ?? "").styledText(semanticFont: .description).padding(EdgeInsets.init(top: 20, leading: 0, bottom: 0, trailing: 10))
                }
            
        }}.navigationBarTitle(Text(viewModel.heading), displayMode: .inline)
            .padding()
    }
}
