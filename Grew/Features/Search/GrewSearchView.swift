//
//  GrewSearchView.swift
//  Grew
//
//  Created by 김효석 on 10/10/23.
//

import SwiftUI

struct GrewSearchView: View {
    @State private var searchText: String = ""
    @State private var searchHistory: [String] = []
    @State private var searchedGrewList: [Grew] = []
    
    @FocusState private var isTextFieldFocused: Bool
    
    @EnvironmentObject var grewViewModel: GrewViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                makeSearchBar()
                ScrollView {
                    makeSearchHistoryView()
                }
            }
            .padding()
            .onAppear {
                grewViewModel.fetchGrew()
            }
        }
    }
    
    /// 검색 텍스트필드 View
    func makeSearchBar() -> some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField("검색어를 입력하세요.", text: $searchText)
                    .submitLabel(.search)
                    .focused($isTextFieldFocused)
                    .onSubmit {
                        searchGroup()
                    }
                
                if !searchText.isEmpty {
                    Button {
                        searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color(hex: 666666))
                    }
                }
            }
            .padding(10)
            .background(Color(red: 242, green: 242, blue: 242))
            .cornerRadius(5)
            
            Spacer()
            
            if isTextFieldFocused {
                Button {
                    isTextFieldFocused = false
                } label: {
                    Text("취소")
                }
            }
        }
    }
    
    /// 검색 기록 View
    func makeSearchHistoryView() -> some View {
        VStack {
            if !searchHistory.isEmpty {
                VStack(alignment: .leading) {
                    HStack {
                        Text("검색 내역")
                            .bold()
                        Spacer()
                        Button {
                            searchHistory.removeAll()
                        } label: {
                            Text("모두 삭제")
                        }
                    }
                    .padding(5)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(searchHistory, id: \.self) { history in
                                Button {
                                    searchText = history
                                    isTextFieldFocused = true
                                } label: {
                                    Text(history)
                                        .foregroundStyle(.white)
                                        .padding(5)
                                }
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundStyle(Color(red: 37, green: 197, blue: 120))
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 5)
                }
            }
        }
    }
    
    /// Grew 검색 함수
    func searchGroup() {
        if !searchText.trimmingCharacters(in: .whitespaces).isEmpty {
            
            searchText = searchText.trimmingCharacters(in: .whitespaces)
            
            if let duplicatedIndex = searchHistory.firstIndex(of: searchText) {
                searchHistory.remove(at: duplicatedIndex)
            }
            
            if searchHistory.count >= 10 {
                searchHistory.removeLast()
            }
            searchHistory.insert(searchText, at: 0)
            
            searchedGrewList = grewViewModel.grewList.filter {
                $0.title.localizedStandardContains(searchText)
            }
        }
    }
}

#Preview {
    GrewSearchView()
}
