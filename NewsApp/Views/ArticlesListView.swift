//
//  ArticlesListView.swift
//  NewsApp
//
//  Created by Imen Ksouri on 05/04/2023.
//

import SwiftUI

struct ArticlesListView: View {
    @Binding var articles: [Article]
    @Binding var showingArticles: Bool
    
    let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(articles) { article in
                    NavigationLink {
                        ArticleDetailView(article: article)
                    } label: {
                        ArticleSummaryView(article: article)
                    }
                }
            }
        }
        .padding(.horizontal)
        .navigationTitle("Articles")
    }
}

struct ArticlesListView_Previews: PreviewProvider {
    @State static private var articles = Article.sampleArticles
    static var previews: some View {
        ArticlesListView(articles: $articles, showingArticles: .constant(true))
    }
}
