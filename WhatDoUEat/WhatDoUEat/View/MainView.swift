//
//  MainView.swift
//  WhatDoUEat
//
//  Created by 김태호 on 2022/08/30.
//

import SwiftUI

struct MainView: View {
    @State var isActionSheetShow: Bool = false
    var body: some View {
        ZStack {
            Color.mainYellow.ignoresSafeArea()
            VStack {
                // MARK: TitleBox Group
                VStack {
                    TitleBox(title: "이걸로")
                    TitleBox(title: "뭐", isMiddleCharacter: true)
                    TitleBox(title: "해먹지?")
                }
                
                Spacer()
                
                Button {
                    self.isActionSheetShow = true
                } label: {
                    RoundedRectangle(cornerRadius : 15)
                        .foregroundColor(.white)
                        .overlay(
                            HStack {
                                Text("이미지 추가하기")
                                Image(systemName: "plus.circle")
                            }
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.black)
                        )
                }
                .frame(height: 63)
                .actionSheet(isPresented: $isActionSheetShow) {
                    ActionSheet(title: Text("사진을 찍거나 앨범에서 사진을 불러오세요"),
                                message: Text(""),
                                buttons: [.default(Text("앨범에서 가져오기"), action: {
//                        self.source = .photoLibrary
//                        self.imagePicker.toggle()
                    }), .default(Text("사진 찍기"), action: {
//                        self.source = .camera
//                        self.imagePicker.toggle()
                    }), .cancel(Text("취소"))]
                    )
                }
            }.padding(.horizontal, 30)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


struct TitleBox: View {
    var title: String
    var isMiddleCharacter: Bool = false
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: isMiddleCharacter ? 76 : 72, weight: .bold))
                .foregroundColor(isMiddleCharacter ? .mainPurple : .black)
                
            Spacer()
        }
    }
}



