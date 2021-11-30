//
//  ArticleItemView.swift
//  NYTimesMostPopularArticles
//
//  Created by ANSAR on 29/11/21.
//

import SwiftUI

struct ArticleItemView: View {
    
    @ObservedObject var viewModel : ArticlesDetailsViewModel
    init(article:Article) {
        viewModel = ArticlesDetailsViewModel(article: article)
    }
    
    
    var body: some View {
        
        HStack(alignment: VerticalAlignment.top, spacing: 0) {
                UrlImageView(urlString: viewModel.image).frame(width: 40, height: 40, alignment: Alignment.center).cornerRadius(20).padding(EdgeInsets.init(top: 5, leading: 0, bottom: 0, trailing: 0))
            VStack(alignment: HorizontalAlignment.leading, spacing: 5) {
                Text(viewModel.heading).styledText(semanticFont: .subHeading).padding(EdgeInsets.init(top: 5, leading: 10, bottom: 0, trailing: 10))
                Text(viewModel.name).styledText(semanticFont: .description).padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                DateView(date: viewModel.date).padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 0))
            }
        }
    }
}

struct DateView: View {
    var date:String = ""
    init(date:String) {
        self.date = date
    }
    var body: some View {
        HStack {
            Image(systemName: "calendar").padding(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            Text(date).styledText(semanticFont: .description).padding(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 10))
        }
    }
}
