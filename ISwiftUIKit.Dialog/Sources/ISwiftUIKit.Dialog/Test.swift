//
//  Test.swift
//  ISwiftUIKit.Dialog
//
//  Created by Taiyou on 2025/9/9.
//
import SwiftUI
struct ContentView: View {
    @State private var showAlert = false
    @State private var showSheet = false
    @State private var showConfirmationDialog = false
    @Environment(\.dialogViewController) private var holder
    
    var body: some View {
        ZStack {
            
            VStack(spacing: 20) {
                Text("SwiftUI 弹框示例")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 30)
                
                // Alert 弹框
                Button("显示 Alert") {
                    showAlert = true
                }
                .buttonStyle(PrimaryButtonStyle())
                
                // Sheet 弹框
                Button("显示 Sheet") {
                    showSheet = true
                }
                .buttonStyle(PrimaryButtonStyle())
                
                // Confirmation Dialog
                Button("显示操作菜单") {
                    showConfirmationDialog = true
                }
                .buttonStyle(PrimaryButtonStyle())
                
                // 自定义弹框
                Button("显示自定义弹框") {
                    holder?.present(builder: {
                        DialogView()
                    })
                }
                .buttonStyle(PrimaryButtonStyle())
            }
            .padding()
        }
        // Alert 弹框
        .alert(
            "重要提示",
            isPresented: $showAlert,
            actions: {
                Button("确定", role: .none) {
                    print("Alert 确定")
                }
                Button("取消", role: .cancel) {
                    print("Alert 取消")
                }
            },message: {
                Text("这是一个 Alert 弹框示例")
            })
        // Sheet 弹框
        .sheet(isPresented: $showSheet) {
            SheetView()
        }
        // Confirmation Dialog (操作菜单)
        .confirmationDialog("请选择一个选项", isPresented: $showConfirmationDialog, titleVisibility: .visible,actions: {
            Button("选项一") {
                print("选项一")
            }
            Button("选项二") {
                print("选项二")
            }
            Button("取消", role: .cancel) {
                print("操作菜单取消")
            }
        })
    }
}



// Sheet 视图
struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("这是一个 Sheet 视图")
                    .font(.title2)
                
                Button("选择此选项") {
                    dismiss()
                    print("Sheet 选项")
                    
                }
                .buttonStyle(PrimaryButtonStyle())
            }
            .padding()
            .navigationTitle("Sheet 示例")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("取消") {
                        dismiss()
                        print("Sheet 取消")
                    }
                }
            }
        }
    }
}

// 自定义按钮样式
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.blue)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue.opacity(0.2))
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

// 预览
#Preview {
    ContentView()
}
