//
//  SearchForm.swift
//  NewsApp
//
//  Created by Imen Ksouri on 12/04/2023.
//

import SwiftUI

enum DateSelection: String, CaseIterable {
    case yes, no
}

enum Period: String, CaseIterable {
    case all = "All periods"
    case oneHour = "1h"
    case twentyFourHours = "24h"
    case sevenDays = "7d"
    case thirtyDays = "30d"
}

struct SearchForm: View {
    var keyword: Binding<String>?
    var dateFrom: Binding<Date>?
    var dateTo: Binding<Date>?
    var dateSelection: Binding<DateSelection>?
    var topic: Binding<Topic>?
    @Binding var country: Country
    @Binding var language: Language
    var period: Binding<Period>?
    var sources: Binding<String>?
    var isSearchingArticles: Binding<Bool>?
    var isSearchingLatestHeadlines: Binding<Bool>?
    var isSearchingSources: Binding<Bool>?
    
    var body: some View {
        Group {
            if let isSearchingArticles = isSearchingArticles {
                if isSearchingArticles.wrappedValue == true {
                    if let keyword = keyword {
                        TextField("Keyword (required)", text: keyword)
                    }

                    if let dateSelection = dateSelection {
                        Text("Would you like to filter out the articles by their published date ?")

                        Picker("Date selection", selection: dateSelection) {
                            ForEach(DateSelection.allCases, id: \.self) { selection in
                                Text(selection.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)

                        if dateSelection.wrappedValue.rawValue == "yes" {
                            if let dateFrom = dateFrom {
                                DatePicker(selection: dateFrom, in: ...Date.now, displayedComponents: .date) {
                                    Text("Date from")
                                }
                            }

                            if let dateTo = dateTo {
                                DatePicker(selection: dateTo, in: ...Date.now, displayedComponents: .date) {
                                    Text("Date to")
                                }
                            }
                        }
                    }
                }
            }
            
            if let isSearchingLatestHeadlines = isSearchingLatestHeadlines, let isSearchingSources = isSearchingSources {
                if isSearchingLatestHeadlines.wrappedValue == true || isSearchingSources.wrappedValue == true {
                    if let topic = topic {
                        Picker("Topic", selection: topic) {
                            ForEach(Topic.allCases, id: \.self) { topic in
                                Text(topic.rawValue.capitalized)
                            }
                        }
                        .pickerStyle(.navigationLink)
                    }
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
            
            if let isSearchingLatestHeadlines = isSearchingLatestHeadlines {
                if isSearchingLatestHeadlines.wrappedValue == true {
                    if let period = period {
                        Picker("Period", selection: period) {
                            ForEach(Period.allCases, id: \.self) { period in
                                Text(period.rawValue)
                            }
                        }
                        .pickerStyle(.navigationLink)
                    }

                    if let sources = sources {
                        Text("Below you can enter one or more news resources to filter your search, separated by commas and without whitespaces :")
                        TextField("Ex: nytimes.com,theguardian.com", text: sources)
                    }

                }
            }
        }
    }
}


struct SearchForm_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var keyword = ""
        @State private var dateFrom = Date()
        @State private var dateTo = Date()
        @State private var dateSelection: DateSelection = .no
        @State private var period: Period = .all
        @State private var country: Country = .ALL
        @State private var language: Language = .all
        @State private var topic: Topic = .all
        @State private var sources = ""
        @State private var isSearchingArticles = true
        @State private var isSearchingLatestHeadlines = true
        @State private var isSearchingSources = true

        var body: some View {
            SearchForm(keyword: $keyword, dateFrom: $dateFrom, dateTo: $dateTo, dateSelection: $dateSelection, topic: $topic, country: $country, language: $language, period: $period, sources: $sources, isSearchingArticles: $isSearchingArticles, isSearchingLatestHeadlines: $isSearchingLatestHeadlines, isSearchingSources: $isSearchingSources)
        }
    }
    static var previews: some View {
        Form {
            PreviewWrapper()
        }
        .padding(5)
    }
}
