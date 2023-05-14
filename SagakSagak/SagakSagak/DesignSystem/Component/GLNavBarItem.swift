//
//  GLBavBarItem.swift
//  SagakSagak
//
//  Created by Joy on 2023/05/13.
//

import SwiftUI

struct GLNavBarItem: View {
    @EnvironmentObject private var coordinator: Coordinator
    
    let navBarTitle: String
    let navBarBgColor: Color
    let navBarFontColor: Color
    
    var body: some View {
        ZStack{
            HStack{
                GLNavBarTitle(navBarTitle: navBarTitle, navBarBgColor: navBarBgColor, navBarFontColor: navBarFontColor)
                Button {
                    coordinator.popToRoot()
                } label: {
                    Image("button_exit")
                        .padding(EdgeInsets(top: 5, leading: 128, bottom: 5, trailing: 0))
                }
            }
        }
        .padding(EdgeInsets(top: 24, leading: 200, bottom: 318, trailing: 24))
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

    }
}

struct GLBavBarItem_Previews: PreviewProvider {
    static var previews: some View {
        GLNavBarItem(navBarTitle: "가람이에게 가장 소중한 것을 그려보자1", navBarBgColor: .system1, navBarFontColor: .system2)
    }
}