//
//  Test1.swift
//  ISwiftUIKit.Dialog
//
//  Created by Taiyou on 2025/9/9.
//
import SwiftUI

struct ContentView1: View {
    @State private var showConfirmationDialog = false
    @Environment(\.dialogViewController) private var holder
    
    var body: some View {
        ZStack {
            // 自定义弹框
            Button("显示自定义弹框") {
                holder?.present(builder: {
                    DialogView()
                })
            }
            .buttonStyle(PrimaryButtonStyle())
        }
    }
}

struct DialogView:View {
    @Environment(\.dialogViewController) private var holder
    
    var body: some View {
//        DialogContainerView(
//            onDismissRequest: {},
//            content: { root in
//                Image(systemName: "person.circle.fill")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 250)
//                    .cornerRadius(10)
//                    .onTapGesture(perform: {
//                        root.disappear()
//                        root.dismiss()
//                    })
//            })
        
        DialogContainerView(duration: 0.2, onDismissRequest: {}, content: { actions in
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250)
                    .cornerRadius(10)
                    .onTapGesture(perform: {
//                        actions.disappear()
//                        actions.dismiss(false)
                        holder?.present(builder: {
                            LoadingView()
                        })
                    })
        })
    }
}

struct LoadingView:View {
    var body: some View {
        DialogContainerView(onDismissRequest: {
            
        }, content: { actions in
            ZStack(content: {
                ProgressView()
            })
            .frame(width: 100,height: 100)
            .background(Color.white)
        })
    }
}

//// 自定义按钮样式
//struct PrimaryButtonStyle: ButtonStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .font(.headline)
//            .foregroundColor(.white)
//            .frame(maxWidth: .infinity)
//            .padding()
//            .background(Color.blue)
//            .cornerRadius(12)
//            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
//            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
//    }
//}

// 预览
#Preview {
    ContentView1()
}
