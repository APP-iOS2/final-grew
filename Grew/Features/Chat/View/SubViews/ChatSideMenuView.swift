//
//  ChatSideMenuView.swift
//  ChatTestProject
//
//  Created by daye on 2023/09/26.
//

import SwiftUI

struct ChatSideMenuView: View {
    @Binding var isMenuOpen: Bool
    
    var body: some View {
        ZStack{
            sideBackground
            sideMainMenu
        }
        .frame(width: ((UIScreen.main.bounds.width/3)*2), height:UIScreen.main.bounds.height-30, alignment: .leading)
    }
    
    //사이드 메인
    private var sideMainMenu: some View {
        VStack(alignment:.leading){
            Text("멋쟁이보드게임").bold().padding(.top, 50)
            Divider()
            ScrollView{
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
                Spacer()
            }
            Divider()
            sideBottomItems.padding(.bottom, 30)
        } .padding()
    }
    
    //사이드 바텀
    private var sideBottomItems: some View {
        HStack{
            Image(systemName: "rectangle.portrait.and.arrow.right")
        }.shadow(radius: 2).padding()
    }
    
    //사이드 백그라운드
    private var sideBackground: some View {
        Rectangle()
            .frame(width: ((UIScreen.main.bounds.width/4)*3), height: UIScreen.main.bounds.height)
            .background(.white)
            .shadow(radius: 300)
            .foregroundColor(.white)
            .ignoresSafeArea()
    }
}

struct ChatSideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ChatSideMenuView(isMenuOpen: .constant(true))
    }
}
