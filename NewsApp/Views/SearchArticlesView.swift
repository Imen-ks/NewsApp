//
//  FormSearchArticlesView.swift
//  NewsApp
//
//  Created by Imen Ksouri on 04/04/2023.
//

enum DateSelection: String, CaseIterable {
    case yes, no
}

import SwiftUI

struct SearchArticlesView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var articles: [Article] = []
    @State private var keyword = ""
    @State private var dateFrom = Date()
    @State private var dateTo = Date()
    @State private var dateSelection: DateSelection = .no
    @State private var country: Country = .ALL
    @State private var language: Language = .all
    @State private var showAlert = false
    @State private var showingArticles = false
    
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
                    TextField("Keyword (required)", text: $keyword)
                        .autocorrectionDisabled()
                    
                    Text("Would you like to filter out the articles by their published date ?")
                    
                    Picker("Date selection", selection: $dateSelection) {
                        ForEach(DateSelection.allCases, id: \.self) { selection in
                            Text(selection.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    if dateSelection == .yes {
                        DatePicker(selection: $dateFrom, in: ...Date.now, displayedComponents: .date) {
                            Text("Date from")
                        }
                        
                        DatePicker(selection: $dateTo, in: ...Date.now, displayedComponents: .date) {
                            Text("Date to")
                        }
                    }
                    
                    Picker("Publisher Country", selection: $country) {
                        ForEach(Country.allCases.sorted { $0.rawValue < $1.rawValue }, id: \.self) { country in
                            Text(country.rawValue)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                    Picker("Article Language", selection: $language) {
                        ForEach(Language.allCases.sorted { $0.rawValue < $1.rawValue }, id: \.self) { language in
                            Text(language.rawValue)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                .padding(5)
                Section {
                    Button {
                        if keyword.isEmpty {
                            showAlert = true
                        } else {
                            showingArticles.toggle()
                            viewModel.updateSearchArticlesRequestParams(keyword: keyword, from: dateFromParam, to: dateToParam, language: languageParam, country: countryParam)
                            Task {
                                do {
                                    if let newsApiResponse = try await viewModel.loadSearchedArticles() {
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
            .environmentObject(ViewModel())
    }
}
