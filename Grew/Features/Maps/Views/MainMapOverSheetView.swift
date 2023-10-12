//
//  MainMapOverSheetView.swift
//  Grew
//
//  Created by 마경미 on 10.10.23.
//

import SwiftUI

struct MainMapOverSheetView: View {
    private var handleAction: () -> Void
    
    init(handleAction: @escaping () -> Void) {
        self.handleAction = handleAction
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                
                // List Handle
                HStack(alignment: .center) {
                    Rectangle()
                        .frame(width: 25, height: 4, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .cornerRadius(10)
                        .opacity(0.25)
                        .padding(.vertical, 8)
                }
                .frame(width: geometry.size.width, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .onTapGesture {
                    handleAction()
                }
                
                Image(systemName: "line.3.horizontal.circle")
                List(0..<5) {_ in
                    MapListItemView()
                }
            }.frame(maxWidth: .infinity)
        }
    }}

#Preview {
    MainMapOverSheetView(handleAction: {
        
    })
}
