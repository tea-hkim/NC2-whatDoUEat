//
//  MainView.swift
//  WhatDoUEat
//
//  Created by 김태호 on 2022/08/30.
//

import SwiftUI

struct MainView: View {
    @State var imageData: Data = .init(capacity: 0)
    @State var isActionSheetShow: Bool = false
    @State var isImagePickerPresented = false
    @State var source: UIImagePickerController.SourceType = .photoLibrary
    @State var predictinoVegetable: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: ImagePicker(
                    isPresented: $isImagePickerPresented,
                    selectedImage: $imageData,
                    predictionVegetable: $predictinoVegetable,
                    sourceType: source), isActive: $isImagePickerPresented) {
                        Text("")
                    }
                
                ZStack {
                    Color.mainYellow.ignoresSafeArea()
                    VStack {
                        // MARK: TitleBox Group
                        VStack {
                            TitleBox(title: "이걸로")
                            TitleBox(title: "뭐", isMiddleCharacter: true)
                            TitleBox(title: "해먹지?")
                        }
                        .padding(.top, 20)
                        .padding(.leading, 5)
                        
                        if imageData.count != 0 {
                            Image(uiImage: UIImage(data: self.imageData)!)
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 200, height: 200)
                        } else {
                            Image(systemName: "fork.knife.circle.fill")
                                .resizable()
                                .frame(width: 200, height: 200)
                        }
                        
                        Spacer()
                        
                        VStack(spacing: 15) {
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
                                            buttons: [
                                                .default(Text("앨범에서 가져오기"), action: {
                                                    self.source = .photoLibrary
                                                    self.isImagePickerPresented.toggle()
                                                }),
                                                .default(Text("사진 찍기"), action: {
                                                    self.source = .camera
                                                    self.isImagePickerPresented.toggle()
                                                }),
                                                .cancel(Text("취소"))]
                                )
                            }
                            NavigationLink {
                                RecipeListView(vegetableName: $predictinoVegetable)
                            } label: {
                                RoundedRectangle(cornerRadius : 15)
                                    .stroke(.black,
                                            lineWidth: predictinoVegetable.isEmpty ?
                                            0 : 3
                                    )
                                    .background(
                                        RoundedRectangle(cornerRadius : 15)
                                            .fill(
                                                predictinoVegetable.isEmpty ?
                                                Color.lightGray :
                                                Color.buttonYello
                                            )
                                    )
                                    .frame(height: 63)
                                    .overlay(
                                        Text("레시피 확인하기")
                                            .font(.system(size: 18, weight: .medium))
                                            .foregroundColor(.black)
                                    )
                            }.disabled(predictinoVegetable.isEmpty)
                        }
                    }.padding(.horizontal, 30)
                }
                .navigationBarHidden(true)
            }
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



