//
//  ChatSideBar.swift
//  Grew
//
//  Created by daye on 10/11/23.
//

import SwiftUI

struct ChatSideBar: View {
    @Binding var isMenuOpen: Bool
    @Binding var isExitButtonAlert: Bool
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @State var show = true
    
    var body: some View {
        HStack(spacing: 0){
            Spacer(minLength: 0)
            Divider()
            VStack(alignment: .leading){
                Text("멋쟁이보드게임")
                    .bold()
                    .padding(.top, 20)
                Divider()
                ScrollView{
                    Group{
                        HStack{
                            Text("함께하는 멤버")
                            Text("6").foregroundColor(.gray)
                        }.padding(.top, 10)
                        ForEach(0..<6) { i in
                            HStack {
                                Image(systemName: "person.crop.circle.fill").font(.system(size: 30))
                                Text("정금쪽").font(.callout).padding(3)
                            }
                            .padding(.top, 10)
                        }
                    }.frame(width: UIScreen.main.bounds.width - 120, alignment: .leading)
                }.frame(height: (UIScreen.main.bounds.height/4)*3)
                
                Divider()
                sideBottomItems
                Spacer()
                
            }
            .padding(.horizontal, 20)
            .padding(.top, edges!.top == 0 ? 15 : edges?.top)
            .padding(.bottom, edges!.bottom == 0 ? 15 : edges?.bottom)
            .frame(width: UIScreen.main.bounds.width - 90 )
            .background(Color.white)
            
        }
    }
    
    private var sideBottomItems: some View {
        HStack{
            Image(systemName: "rectangle.portrait.and.arrow.right")
                .onTapGesture {
                    isExitButtonAlert.toggle()
                }
        }.padding()
    }
}

#Preview {
    ChatSideBar(isMenuOpen: .constant(true), isExitButtonAlert: .constant(true))
}
