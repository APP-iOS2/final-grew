//
//  GrewSearchView.swift
//  Grew
//
//  Created by 김효석 on 10/10/23.
//

import SwiftUI

struct GrewSearchView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var searchText: String = ""
    @State private var searchHistory: [String] = []
    @State private var searchedGrewList: [Grew] = []
    
    @State private var selectedCategory: GrewCategory? = nil
    @State private var isShowingCategory: Bool = true
    
    @FocusState var isTextFieldFocused: Bool
    
    @EnvironmentObject var grewViewModel: GrewViewModel
    
    private let gridItems: [GridItem] = [
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible()),
    ]
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                GrewTextField(
                    text: $searchText,
                    isWrongText: false,
                    isTextfieldDisabled: false,
                    placeholderText: "검색어를 입력하세요.",
                    isSearchBar: true
                )
                .padding(.top)
                .onSubmit {
                    searchGroup()
                }
                
                ScrollView {
                    makeSearchHistoryView()
                    makeCategorySelection()
                    GrewSearchListView(grewList: searchedGrewList)
                        .padding(.horizontal, -16)
                }
            }
            .padding(.horizontal, 16)
            .scrollDismissesKeyboard(.immediately)
            .navigationTitle("Grew 검색")
            .onAppear {
                grewViewModel.fetchGrew()
                searchHistory = UserStore.shared.currentUser?.searchHistory ?? []
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 25))
                        .foregroundStyle(Color.black)
                        .padding()
                }
                Spacer()
            }
        }
    }
}

// View 반환 함수
extension GrewSearchView {
    /// 검색 기록 View
    private func makeSearchHistoryView() -> some View {
        VStack {
            if !searchHistory.isEmpty {
                VStack(alignment: .leading) {
                    HStack {
                        Text("검색 내역")
                            .font(.b1_B)
                        Spacer()
                        Button {
                            searchHistory.removeAll()
                            UserStore.shared.updateSearchHistory(searchHistory: searchHistory)
                        } label: {
                            Text("모두 삭제")
                                .font(.b2_R)
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
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 8)
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
        .padding(.bottom)
    }
    
    @ViewBuilder
    private func makeCategorySelection() -> some View {
        HStack {
            Button {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isShowingCategory.toggle()
                }
            } label: {
                HStack {
                    Text("카테고리 선택")
                    Image(systemName: isShowingCategory ? "chevron.down" : "chevron.forward")
                        .padding(.bottom, 3)
                }
                .font(.b1_B)
                .foregroundStyle(.black)
                .padding(5)
            }

            Spacer()
            if selectedCategory != nil {
                Button {
                    selectedCategory = nil
                } label: {
                    Text("선택 취소")
                        .font(.b2_R)
                }
            }
        }
        
        if isShowingCategory {
            LazyVGrid(columns: gridItems) {
                ForEach(grewViewModel.categoryArray) { category in
                    VStack {
                        Image("\(category.imageString)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                        
                        Capsule()
                            .foregroundColor(.clear)
                            .overlay(
                                Text(category.name)
                                    .font(.c1_R)
                                    .foregroundStyle(.black)
                            )
                    }
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .background(selectedCategory?.id == category.id ? Color(hexCode: "#FF7E00") : .white)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray, lineWidth: 1.5)
                    )
                    .onTapGesture {
                        if selectedCategory?.id == category.id {
                            selectedCategory = nil
                        } else {
                            selectedCategory = category
                        }
                    }
                }
            }
        }
        
        Divider()
            .padding(.vertical, 10)
    }
}

// 기능 함수
extension GrewSearchView {
    
    /// Grew 검색 함수
    private func searchGroup() {
        if !searchText.trimmingCharacters(in: .whitespaces).isEmpty {
            
            searchText = searchText.trimmingCharacters(in: .whitespaces)
            
            if let duplicatedIndex = searchHistory.firstIndex(of: searchText) {
                searchHistory.remove(at: duplicatedIndex)
            }
            
            if searchHistory.count >= 10 {
                searchHistory.removeLast()
            }
            searchHistory.insert(searchText, at: 0)
            UserStore.shared.updateSearchHistory(searchHistory: searchHistory)
            
            searchedGrewList = grewViewModel.grewList.filter {
                if let categoryId = selectedCategory?.id {
                    $0.categoryIndex == categoryId &&
                    $0.title.localizedStandardContains(searchText)
                } else {
                    $0.title.localizedStandardContains(searchText)
                }
            }
        }
    }
}

#Preview {
    GrewSearchView()
        .environmentObject(GrewViewModel())
}
