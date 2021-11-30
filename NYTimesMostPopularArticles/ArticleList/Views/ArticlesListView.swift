//
//  ContentView.swift
//  NYTimesMostPopularArticles
//
//  Created by ANSAR on 29/11/21.
//

import SwiftUI

struct ArticleListView: View {
    @ObservedObject var viewmodel = ArticlesViewModel()
   
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                if viewmodel.loading {
                    ActivityIndicator(color: Color.blue, size: 50).accessibilityLabel("activityIndicator")
                } else {
                    if (viewmodel.articleList.count > 0) {
                        List(viewmodel.articleList) { article in
                            let id = article.id?.description
                            NavigationLink(destination: ArticleDetails(article:article)){
                                ArticleItemView(article: article).accessibilityLabel(id ?? "")
                            }
                        }.accessibilityLabel("listView")
                    } else {
                        VStack(alignment: .center) {
                            Text("No Articles or error")
                        }
                    }
                }
            }
            
            .navigationBarTitle(Text("Articles"))
            .onAppear {
                self.viewmodel.loadData()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView()
    }
}
