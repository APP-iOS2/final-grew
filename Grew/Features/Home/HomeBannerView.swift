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
        // 전체 케이스
        let all = Self.allCases
        // 현재 인덱스는 전체 인덱스의 첫번째 인덱스
        let idx = all.firstIndex(of: self)!
        // 다음인덱스는 전체 인덱스의 현재 인덱스의 다음(after)
        let next = all.index(after: idx)
        // 다음인덱스가 전체중 마지막인덱스와 같다면 참이면 처음인덱스로 거짓이면 다음인덱스로
        // 현재 인덱스를 보여준다
        return all[next == all.endIndex ? all.startIndex : next]
    }
}

enum BannerContentType: CaseIterable, Identifiable {
    case first
    case second
    case third
    
    var id: Self { self }
    
    @ViewBuilder
    // View로 반환하기 위해서 @ViewBuilder 사용
    func getView() -> some View {
        switch self {
        case .first:
            ZStack {
                Color.Main
                Text("1️⃣")
            }
        case .second:
            ZStack {
                Color.Sub
                Text("2️⃣")
            }
        case .third:
            ZStack {
                Color.DarkGray1
                Text("3️⃣")
            }
        }
    }
}
// View
struct PagingBannerView: View {
    // 현재 선택된 아이템은 첫번째 인덱스
    @State var selectedItem: BannerContentType = .first
    
    @StateObject var vm = PagingBannerViewModel()
    
    var body: some View {
        
        TabView(selection: $selectedItem) {
            ForEach(BannerContentType.allCases) { banner in
                NavigationLink {
                    banner.getView()
                } label: {
                    banner
                        .getView()
                        .tag(banner)
                }
                
            }
        }
        /// 텝뷰를 페이지텝뷰로 스타일 변환
        .tabViewStyle(PageTabViewStyle())
        
        //            .frame(height: 200)
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


// ViewModel
class PagingBannerViewModel: ObservableObject {
    // 배너타입은 BannerContentType enum의 첫번째 값, 값이 바뀌면 바깥에 뿌려준다
    @Published var bannerType: BannerContentType = .first
    
    // AnyCancellable Combine의
    // activity 또는 action이 취소(cancellation)를 지원함을 나타내는 프로토콜
    // cancel()을 호출하면 할당 된 모든 리소스가 해제된다
    private var cancellables = Set<AnyCancellable>()
    
    // 생성자?
    init() {
        // 타이머 5초마다
        Timer.publish(every: 5, on: .main, in: .default)
            .autoconnect()
            .receive(on: DispatchQueue.main)
        // weak 로 약한 참조
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
