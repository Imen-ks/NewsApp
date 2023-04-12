//
//  FormSearchArticlesView.swift
//  NewsApp
//
//  Created by Imen Ksouri on 04/04/2023.
//

import SwiftUI

struct SearchArticlesView: View {
    @ObservedObject var viewModel: ViewModelSearchArticles = ViewModelSearchArticles()
    @State private var articles: [Article] = []
    @State private var keyword = ""
    @State private var dateFrom = Date()
    @State private var dateTo = Date()
    @State private var dateSelection: DateSelection = .no
    @State private var country: Country = .ALL
    @State private var language: Language = .all
    @State private var showAlert = false
    @State private var showingArticles = false
    @State var isSearchingArticles = true
    
    var dateFromParam: String {
        dateSelection == .no ? "no" : getDate(from: dateFrom)
    }
    var dateToParam: String {
        dateSelection == .no ? "no" : getDate(from: dateTo)
    }
    var countryParam: String {
        String(describing: country)
    }
    var languageParam: String {
        String(describing: language)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("ARTICLES SELECTION CRITERIA") {
                    SearchForm(keyword: $keyword, dateFrom: $dateFrom, dateTo: $dateTo, dateSelection: $dateSelection, country: $country, language: $language, isSearchingArticles: $isSearchingArticles)
                }
                .padding(5)
                Section {
                    Button {
                        if keyword.isEmpty {
                            showAlert = true
                        } else {
                            showingArticles.toggle()
                            viewModel.updateParams(keyword: keyword, from: dateFromParam, to: dateToParam, language: languageParam, country: countryParam)
                            Task {
                                do {
                                    if let newsApiResponse = try await viewModel.articles {
                                        articles = newsApiResponse.articles
                                    }
                                } catch{
                                    print(error)
                                }
                            }
                        }
                    } label: {
                        Text("Submit")
                    }
                    .frame(minWidth: 300)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Keword is required"), dismissButton: .default(Text("Ok")))
                    }
                }
                .navigationDestination(isPresented: $showingArticles) {
                    ArticlesListView(articles: $articles, showingArticles: $showingArticles)
                }
            }
            .navigationTitle("Search Articles")
        }
    }
    private func getDate(from date: Date) -> String {
        let calendar = Calendar.current
        let tempDay = calendar.component(.day, from: date)
        let day = tempDay < 10 ? "0\(tempDay)" : "\(tempDay)"
        let tempMonth = calendar.component(.month, from: date)
        let month = tempMonth < 10 ? "0\(tempMonth)" : "\(tempMonth)"
        let year = calendar.component(.year, from: date)
        return  "\(year)/\(month)/\(day)"
    }
}

struct SearchArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchArticlesView()
    }
}
