//
//  MainMapOverSheetView.swift
//  Grew
//
//  Created by 마경미 on 10.10.23.
//

import SwiftUI

struct MainMapOverSheetView: View {
    @EnvironmentObject var viewModel: MapStore
    var handleAction: () -> Void
    
    var body: some View {
        ZStack {
            VStack {
                Spacer(minLength: 30)
                ScrollView {
                    VStack {
                        ForEach(Array(viewModel.filteredListItems)) { item in

                            NavigationLink {
                                GrewDetailView(grew: item)
                            } label: {
                                GrewCellView(grew: item)
                            }
                        }
                    }.frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .padding(.bottom, 320)
            }
            GeometryReader { geometry in
                HStack(alignment: .center) {
                    Rectangle()
                        .frame(width: 25, height: 4, alignment: .center)
                        .cornerRadius(10)
                        .opacity(0.25)
                        .padding(.vertical, 8)
                }
                .frame(width: geometry.size.width, height: 30, alignment: .center)
                .onTapGesture {
                    handleAction()
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    MainMapOverSheetView(handleAction: {
        
    })
}
