//
//  ContentView.swift
//  WhatDoUEat
//
//  Created by 김태호 on 2022/08/30.
//

import SwiftUI

struct ContentView: View {
    @State var imageData: Data = .init(capacity: 0)
    @State var isShow = false
    @State var imagePicker = false
    @State var source: UIImagePickerController.SourceType = .camera
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    ZStack {
                        NavigationLink(destination: ImagePicker(isPresented: $imagePicker,
                                                                selectedImage: $imageData,
                                                                sourceType: source),
                                       isActive: $imagePicker) {
                            Text("")
                        }
                        VStack {
                            if imageData.count != 0 {
                                Image(uiImage: UIImage(data: self.imageData)!)
                                    .resizable()
                                    .clipShape(Circle())
                                    .frame(width: 250, height: 260)
                                    .overlay(Circle().stroke(.red, lineWidth: 5))
                                    .foregroundColor(.purple)
                            } else {
                                Text("")
                            }
                            
                            Button {
                                self.isShow.toggle()
                            } label: {
                                RoundedRectangle(cornerRadius : 15)
                                    .padding(.horizontal, 30)
                                    .foregroundColor(.white)
                                    .overlay(
                                        HStack {
                                            Text("이미지 추가하기")
                                            Image(systemName: "plus.circle")
                                        }
                                    )
                            }
                            .padding(.horizontal, 30)
                            .frame(width: 300, height: 60)
                            .border(.black)
                        }.actionSheet(isPresented: $isShow) {
                            ActionSheet(title: Text("사진을 찍거나 앨범에서 사진을 불러오세요"),
                                        message: Text(""),
                                        buttons: [.default(Text("앨범에서 가져오기"), action: {
                                self.source = .photoLibrary
                                self.imagePicker.toggle()
                            }), .default(Text("사진 찍기"), action: {
                                self.source = .camera
                                self.imagePicker.toggle()
                            }), .cancel()]
                            )
                        }
                    }
                }
                .padding(0)
            }.navigationBarHidden(true)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
