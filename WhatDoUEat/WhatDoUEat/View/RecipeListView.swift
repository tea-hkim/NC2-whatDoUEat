//
//  RecipeListView.swift
//  WhatDoUEat
//
//  Created by 김태호 on 2022/08/31.
//

import SwiftUI

struct RecipeListView: View {
    let dummyData: [String] = ["가지", "호박","가지", "호박","가지", "호박","가지", "호박","가지", "호박","가지", "호박","가지", "호박","가지", "호박","가지", "호박",]
    
    var body: some View {
        VStack {
            RecipeListTitle(ingredient: "가지")
            ZStack {
                List {
                    ForEach ( dummyData, id: \.self) {
                        RecipeBox(recipeName: $0)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                }
                .padding(0)
                .listStyle(.plain)
                VStack {
                    Spacer()
                    Button {
                        print("리셋 버튼")
                    } label: {
                        RoundedRectangle(cornerRadius : 15)
                            .stroke(.black, lineWidth: 3)
                            .background(
                                RoundedRectangle(cornerRadius : 15)
                                    .fill(Color.buttonYello)
                            )
                            .frame(height: 63)
                            .overlay(
                                Text("이미지 추가하기")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.black)
                            )
                    }
                }
            }
        }
        .padding(.horizontal, 30)
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}


struct RecipeListTitle: View {
    var ingredient: String
    var body: some View {
        HStack {
            Text(ingredient + " ")
                .font(.system(size: 44, weight: .bold))
                .foregroundColor(.blue)
            + Text("로 해먹자")
                .font(.system(size: 32, weight: .bold))
            Spacer()
        }
    }
}

struct RecipeBox: View {
    var recipeName: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color.lightYellow)
            .frame(height: 63)
            .overlay (
                Text(recipeName)
            )
            .padding(.bottom, 20)
    }
}
