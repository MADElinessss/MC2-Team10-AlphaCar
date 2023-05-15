//
//  EmotionView.swift
//  SagakSagak
//
//  Created by Joy on 2023/05/14.
//

import SwiftUI

struct EmotionView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @State var onClicked: Bool ///넵바 버튼 조정을 위한 변수
    
    var body: some View {
        ZStack {
            Color.bg3.ignoresSafeArea()
            VStack(spacing:0){
                navBarView
                contentsView
                tabBarView
            }
        }
    }
    
    // MARK: navBar
    var navBarView: some View {
        HStack{
            GLNavBarItem(backPage: .face, backButtonImg: "button_back", shadowOn: true, navBarTitle: "이 표정은 어떤 이름일까?", navBarBgColor: .system2, navBarFontColor: .system1, nextButtonImg: "button_next", nextPage: .story1, nextEnabled: false)
            
            Spacer().frame(width:70)
            
            Button {
                print("Button Tapped")
            } label: {
                Image("button_exit")
                    .shadow(color: Color(hex: "26775F").opacity(0.15),
                            radius: 30,
                            x: 0,
                            y: 4)
                
            }
        }
        .frame(width: Const.glScreenWidth, height: 72)
        //.background(.yellow)
        .padding(.top, 24)
        .padding(.trailing, 24)
        .padding(.leading, 142)
    }
    
    // MARK: Contents
    var contentsView: some View {
        VStack{
            HStack(spacing:16){
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        .shadow(.inner(color: Color.init(hex: "579DFF").opacity(0.3), radius: 10, x:0, y:4))
                    )
                    .frame(width: 100, height:60)
                    .foregroundColor(Color.system2)
                Text("표정의 이름은").font(FontManager.shared.nanumsquare(.bold, 28))
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        .shadow(.inner(color: Color.init(hex: "579DFF").opacity(0.3), radius: 10, x:0, y:4))
                    )
                    .frame(width: 100, height:60)
                    .foregroundColor(Color.system2)
                
                Text("이야.").font(FontManager.shared.nanumsquare(.bold, 28))
            }
        }
        .frame(width: Const.glScreenWidth, height:230)
        //.background(.blue)
    }
    
    //MARK: TabBar
    var tabBarView: some View {
        Rectangle()
        .frame(width: Const.glScreenWidth, height:88)
        .foregroundColor(.system2)
        .overlay{
            GLBlockView()
        }
    }
}



struct EmotionView_Previews: PreviewProvider {
    static var previews: some View {
        EmotionView(onClicked: false)
    }
}
