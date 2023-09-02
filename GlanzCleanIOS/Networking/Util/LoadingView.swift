//
//  LoadingView.swift
//  GlanzCleanIOS
//
//  Created by Adrian Gabriel Chiper on 20.08.2023.
//

import SwiftUI

enum LoadingType {
    case download
    case upload
    case general
}

struct LoadingView: View {
    var loadingType: LoadingType
    @State private var scale1: CGFloat = 1.0
    @State private var scale2: CGFloat = 1.0
    @State private var scale3: CGFloat = 1.0
    
    var body: some View {
        VStack {
            Image(loadingType == .upload ? "UploadImg" : loadingType == .download ? "DownloadImg" : "LoadingImg")
                .resizable()
                .scaledToFit()
                .frame(width: 150)
            Text("Loading...") .font(.custom("Urbanist-Bold", size: 24)).foregroundColor(.white)
            Text("Please wait") .font(.custom("Urbanist-Bold", size: 16)).foregroundColor(.white)
                .padding(.bottom)
            HStack {
                Circle()
                    .fill(.black)
                    .frame(width: 30, height: 30)
                    .scaleEffect(scale1)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                            self.scale1 = 0.7
                        }
                    }
                
                Circle()
                    .fill(.black)
                    .frame(width: 30, height: 30)
                    .scaleEffect(scale2)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).delay(0.2)) {
                            self.scale2 = 0.7
                        }
                    }
                
                Circle()
                    .fill(.black)
                    .frame(width: 30, height: 30)
                    .scaleEffect(scale3)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true).delay(0.4)) {
                            self.scale3 = 0.7
                        }
                    }
            }
        }
        .padding()
        .background(Color("MainYellow"))
        .cornerRadius(12)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(loadingType: .upload)
    }
}
