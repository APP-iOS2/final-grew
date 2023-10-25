//
//  HomeBannerView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/06.
//

import Combine
import SwiftUI

extension CaseIterable where Self: Equatable{
    func next() -> Self {
        let all = Self.allCases
        let idx = all.firstIndex(of: self)!
        let next = all.index(after: idx)
        return all[next == all.endIndex ? all.startIndex : next]
    }
}

enum BannerContentType: CaseIterable, Identifiable {
    case first
    case second
    case third
    case fouth
    case fifth
    case sixth
    case seventh
    
    var id: Self { self }
    
    @ViewBuilder
    func getView() -> some View {
        switch self {
        case .first:
            ZStack {
                Image("banner1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        case .second:
            ZStack {
                Image("banner2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        case .third:
            ZStack {
                Image("banner3")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        case .fouth:
            ZStack {
                Image("banner4")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        case .fifth:
            ZStack {
                Image("banner5")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        case .sixth:
            ZStack {
                Image("banner6")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        case .seventh:
            ZStack {
                Image("banner7")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
    }
}
/// View
struct PagingBannerView: View {
    /// 현재 선택된 아이템은 첫번째 인덱스
    @State var selectedItem: BannerContentType = .first
    @StateObject var vm = PagingBannerViewModel()
    
    var body: some View {
        
        TabView(selection: $selectedItem) {
            ForEach(BannerContentType.allCases) { banner in
                
                banner
                    .getView()
                    .tag(banner)
                
            }
        }
        /// 텝뷰를 페이지텝뷰로 스타일 변환
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        
        /// 진행 되던 순서에서 내가 바꾼 현재의 순서로 수정함
        .onChange(of: selectedItem, perform: { newValue in
            vm.onChangeBanner(to: newValue)
        })
        /// 자동으로 이동하게 해줌
        .onReceive(vm.$bannerType) { banner in
            withAnimation {
                selectedItem = banner
            }
        }
    }
    
}


/// ViewModel
class PagingBannerViewModel: ObservableObject {
    @Published var bannerType: BannerContentType = .first
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        Timer.publish(every: 5, on: .main, in: .default)
            .autoconnect()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.bannerType = self.bannerType.next()
            }
            .store(in: &cancellables)
    }
    
    func onChangeBanner(to type: BannerContentType) {
        let all = BannerContentType.allCases
        guard let index = all.firstIndex(of: type),
        let currentIndex = all.firstIndex(of: bannerType) else {
            return
        }
        
        if currentIndex != index {
            bannerType = type
        }
    }
}

#Preview {
    PagingBannerView()
}
