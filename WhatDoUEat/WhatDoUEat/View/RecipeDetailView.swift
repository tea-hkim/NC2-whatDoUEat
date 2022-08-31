//
//  RecipeDetailView.swift
//  WhatDoUEat
//
//  Created by 김태호 on 2022/08/31.
//

import SwiftUI

struct RecipeDetailView: View {
    var number: Int = 1
    var recipeName: String = "가지 덮밥"
    var body: some View {
        VStack {
//            Image("")
            
            // MARK: 레시피 타이틀 박스
            HStack {
                Text(recipeName)
                    .font(.system(size: 32, weight: .bold))
                    .padding(.leading, 30)
                    .padding(.vertical, 17)
                Spacer()
            }
            
            // MARK: 레시피를 쓰는 곳입니다
            VStack(alignment: .leading) {
                recipeProcess(number: 1)
            }
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.lightYellow)
            )
            .padding(.horizontal, 18)
        }
    }
}


struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView()
    }
}

struct recipeProcess: View {
    var number: Int
    var body: some View {
        HStack {
            Text(String(number))
            Text("Recipe입니다")
                .padding(.leading, 15)
            Spacer()
        } .padding(.horizontal, 33)
    }
}
