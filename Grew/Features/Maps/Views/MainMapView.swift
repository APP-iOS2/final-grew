//
//  MainMapView.swift
//  Grew
//
//  Created by 마경미 on 10.10.23.
//

import SwiftUI

struct MainMapView: View {
    private let scrollViewHeight: CGFloat = 80
    
    @State private var expandList: Bool = false
    @State private var yDragTranslation: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                NaverMapView()
                MainMapOverSheetView(handleAction: {
                    self.expandList.toggle()
                })
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(
                    x: 0,
                    y: geometry.size.height - (expandList ? scrollViewHeight + 150 : scrollViewHeight)
                )
                .offset(x: 0, y: self.yDragTranslation)
                .animation(.spring(), value: 1)
                .gesture(
                    DragGesture().onChanged { value in
                        self.yDragTranslation = value.translation.height
                    }.onEnded { value in
                        self.expandList = (value.translation.height < -120)
                        self.yDragTranslation = 0
                    }
                )
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    MainMapView()
}
