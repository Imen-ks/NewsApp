//
//  FormSearchLatestHeadlinesView.swift
//  NewsApp
//
//  Created by Imen Ksouri on 05/04/2023.
//

enum Period: String, CaseIterable {
    case all = "All periods"
    case oneHour = "1h"
    case twentyFourHours = "24h"
    case sevenDays = "7d"
    case thirtyDays = "30d"
}

import SwiftUI

struct SearchLatestHeadlinesView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var headlines: [Article] = []
    @State private var period: Period = .all
    @State private var country: Country = .ALL
    @State private var language: Language = .all
    @State private var topic: Topic = .all
    @State private var sources = ""
    @State private var showingLatestHeadlines = false
    
    var periodParam: String {
        String(describing: period.rawValue)
    }
    var countryParam: String {
        String(describing: country)
    }
    var languageParam: String {
        String(describing: language)
    }
    var topicParam: String {
        String(describing: topic)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("HEADLINES SELECTION CRITERIA") {
                    Picker("Topic", selection: $topic) {
                        ForEach(Topic.allCases, id: \.self) { topic in
                            Text(topic.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                    Picker("Period", selection: $period) {
                        ForEach(Period.allCases, id: \.self) { period in
                            Text(period.rawValue)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
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
                    
                    Text("Below you can enter one or more news resources to filter your search, separated by commas and without whitespaces :")
                    TextField("Ex: nytimes.com,theguardian.com", text: $sources)
                        .autocorrectionDisabled()
                }
                .padding(5)
                Section {
                    Button {
                        showingLatestHeadlines.toggle()
                        viewModel.updateLatestHeadlinesRequestParams(period: periodParam, language: languageParam, country: countryParam, topic: topicParam, sources: sources)
                        Task {
                            do {
                                if let newsApiResponse = try await viewModel.loadLatestHeadlines() {
                                    headlines = newsApiResponse.articles
                                }
                            } catch{
                                print(error)
                            }
                        }
                    } label: {
                        Text("Submit")
                    }
                    .frame(minWidth: 300)
                }
                .navigationDestination(isPresented: $showingLatestHeadlines) {
                    LatestHeadlinesListView(headlines: $headlines, showingLatestHeadlines: $showingLatestHeadlines)
                }
            }
            .navigationTitle("Latest Headlines")
        }
    }
}

struct SearchLatestHeadlinesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchLatestHeadlinesView()
            .environmentObject(ViewModel())
    }
}
