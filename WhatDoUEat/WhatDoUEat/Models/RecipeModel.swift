//
//  RecipeModel.swift
//  WhatDoUEat
//
//  Created by 김태호 on 2022/08/31.
//

import SwiftUI

enum Ingredients: Int {
    case 감자 = 0
    case 당근 = 1
    case 무
    case 브로콜리
    case 양배추
    case 오이
    case 완두콩
    case 콜리플라워
    case 토마토
    case 파프리카
    case 호박
}

struct RecipeModel {
    var recipeName: String
    var ingredients: [Ingredients]
    var cookingProcess: [String]
}

