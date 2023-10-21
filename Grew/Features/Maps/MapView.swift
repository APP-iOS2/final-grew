//
//  MapView.swift
//  Grew
//
//  Created by 정유진 on 2023/10/04.
//

import SwiftUI

struct MapView: View {
    @EnvironmentObject var viewModel: MapStore

    @State private var yDragTranslation: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                NaverMapView()
                MainMapOverTopView()
                MainMapOverSheetView(handleAction: {
                    self.viewModel.expandList.toggle()
                }).frame(height: 800)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(
                    x: 0,
                    y: geometry.size.height - (viewModel.expandList ? 400 : -20)
                )
                .offset(x: 0, y: self.yDragTranslation)
                .animation(.spring(), value: 1)
                .gesture(
                    DragGesture().onChanged { value in
                        self.yDragTranslation = value.translation.height
                    }.onEnded { value in
                        self.viewModel.expandList = (value.translation.height < -80)
                        self.yDragTranslation = 0
                    }
                )
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    MapView()
}
