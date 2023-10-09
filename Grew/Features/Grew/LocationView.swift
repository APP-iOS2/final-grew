//
//  LocationView.swift
//  CircleRecruitment
//
//  Created by 윤진영 on 2023/09/25.
//

import SwiftUI

struct LocationView: View {
    
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("지도??")
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { dismiss() }, label: {
                        Text("닫기")
                            .foregroundColor(.green)
                    })
                }
            }
        }
        
    }
}

#Preview {
    LocationView()
}
