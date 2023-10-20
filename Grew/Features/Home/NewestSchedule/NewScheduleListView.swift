//
//  NewestScheduleListView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/18.
//

import SwiftUI

/// 최신 일정 뷰
struct NewestScheduleListView: View {

    @State private var isShowingSheet: Bool = false
    let quote: String = "\""
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Group {
                        Text(quote)
                            .foregroundStyle(Color.Sub)
                            .padding(.trailing, -5)
                        Text("이사모")
                            .padding(.trailing, -5)
                        Text(quote)
                            .foregroundStyle(Color.Sub)
                    }
                    .font(.h1_B)
                    
                    
                    Text("그루에")
                        .font(.h2_B)
                    Spacer()
                }
                HStack {
                    Text("참여하지 않은 새로운 일정이 있어요!")
                        .font(.h2_B)
                    Spacer()
                }
            }
            .foregroundStyle(.white)
            .padding(.top, 80)
            .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 20) {
                    ForEach(0 ..< 6) { _ in
                        
                        GeometryReader { proxy in
                            let scale = getScale(proxy: proxy)
                            
                            VStack {
                                // Home - GrewDetail 폴더 
                                ScheduleCellView()
                                    .scaledToFill()
                                    .frame(width: 160, height: 160)
                                    .shadow(radius: 6)
                                    .padding(.vertical, 10)
                                    .onTapGesture {
                                        isShowingSheet = true
                                    }
                                
                            } // VStack
                            .scaleEffect(.init(width: scale, height: scale))
                            .animation(.easeOut(duration: 1))
                            .padding(.vertical)
                            
                        } // GeometryReader
                        // 지오메트리 자체에 프레임을 주는 것
                        // 하나 하나 지오메트리를 넣어 크기를준다
                        .frame(width: 170, height: 260)
                        .padding(.horizontal)
                        .padding(.vertical)
                    } // ForEach
                        
                } // HStack
                
            } //: ScrollView
            
        } //: VStack
        .frame(height: 330)
        .background(Color.Main)
        .sheet(isPresented: $isShowingSheet, content: {
            ScheduleDetailView()
        })
        
    
    } //: body
    
    // 뷰의 위치를 기반으로 스케일링 요소를 계산
    // 차이가 특정 임계값 이하인 경우에만 스케일이 조정
    // 이를 통해 뷰의 애니메이션에 활용
    func getScale(proxy: GeometryProxy) -> CGFloat {
        
        // 애니메이션을 트리거하거나 중앙에 위치시키려는 지점을 정의합니다.
        let middlePoint: CGFloat = 225
        
        // GeometryProxy를 사용하여 뷰의 프레임을 전역 좌표 공간에서 가져옵니다.
        let viewFrame = proxy.frame(in: CoordinateSpace.global)
        
        // 초기 스케일 요소를 1.0으로 설정합니다.
        var scale: CGFloat = 1.0
        
        // 뷰의 위치가 middlePoint에 가까울 때 애니메이션을 트리거하는 데 사용됩니다.
        // 애니메이션을 트리거하는 데 사용될 x-축 방향의 임계값을 정의합니다.
        let deltaXAnimationThreshold: CGFloat = 200
        
        // 뷰의 현재 위치와 `middlePoint` 사이의 차이를 계산하고 이를 `deltaXAnimationThreshold`의 절반으로 조정한 값의 절대값을 구합니다.
        let diffFromCenter = abs(middlePoint - viewFrame.origin.x - deltaXAnimationThreshold / 2)
        
        // 차이가 `deltaXAnimationThreshold`보다 작을 경우, 스케일을 조정합니다.
        if diffFromCenter < deltaXAnimationThreshold {
            // 스케일을 1에서 `deltaXAnimationThreshold`와 `diffFromCenter`의 차이를 500으로 나눈 값으로 업데이트합니다.
            scale = 1 + (deltaXAnimationThreshold - diffFromCenter) / 500
        }
        
        return scale
    }
}

#Preview {
    NewestScheduleListView()
}
