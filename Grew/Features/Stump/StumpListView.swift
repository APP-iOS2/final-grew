//
//  StumpListView.swift
//  Grew
//
//  Created by 김효석 on 10/21/23.
//

import SwiftUI

struct StumpListView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var stumpStore: StumpStore
    
    var body: some View {
        List {
            ForEach(stumpStore.stumps) { stump in
                NavigationLink {
                    ScrollView {
                        StumpInputView(
                            name: .constant(stump.name),
                            hours: .constant(stump.hours),
                            isHoursValid: .constant(true),
                            minimumMembers: .constant(stump.minimumMembers),
                            maximumMembers: .constant(stump.maximumMembers),
                            isNeedDeposit: .constant(stump.isNeedDeposit),
                            deposit: .constant(stump.deposit),
                            location: .constant(stump.location),
                            phoneNumber: .constant(stump.phoneNumber),
                            isAllTextFieldDisabled: true,
                            imageURLs: stump.imageURLs
                        )
                        .padding(.horizontal, 20)
                        
                    }
                    
                } label: {
                    StumpCellView(stump: stump)
                }
            }
            .alignmentGuide(.listRowSeparatorLeading) { viewDimensions in
                viewDimensions[.leading]
            }
        }
        .listStyle(.plain)
        .onAppear {
            Task {
                await stumpStore.fetchStumps()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("전체 그루터기")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .font(.system(size: 18))
                        .foregroundStyle(Color.black)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    NavigationStack {
        StumpListView()
    }
    .environmentObject(StumpStore())
}
