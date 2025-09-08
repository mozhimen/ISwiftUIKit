// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI

struct ContentView: View {
    @State private var showAlert = false
    @State private var showSheet = false
    @State private var showConfirmationDialog = false
    @State private var showCustomModal = false
    @State private var selectedOption = "无"
    
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
                    showCustomModal = true
                }
                .buttonStyle(PrimaryButtonStyle())
                
                Text("已选择: \(selectedOption)")
                    .font(.headline)
                    .padding(.top, 20)
            }
            .padding()
            
            // 自定义弹框覆盖层
            if showCustomModal {
                CustomModalView(
                    isPresented: $showCustomModal,
                    selectedOption: $selectedOption
                )
                .transition(.opacity.combined(with: .scale))
                .zIndex(1)
            }
        }
        // Alert 弹框
        .alert(
            "重要提示",
               isPresented: $showAlert,
            actions: {
            Button("确定", role: .none) {
                selectedOption = "Alert 确定"
            }
            Button("取消", role: .cancel) {
                selectedOption = "Alert 取消"
            }
        },message: {
            Text("这是一个 Alert 弹框示例")
        })
        // Sheet 弹框
        .sheet(isPresented: $showSheet) {
            SheetView(selectedOption: $selectedOption)
        }
        // Confirmation Dialog (操作菜单)
        .confirmationDialog("请选择一个选项", isPresented: $showConfirmationDialog, titleVisibility: .visible,actions: {
            Button("选项一") {
                selectedOption = "选项一"
            }
            Button("选项二") {
                selectedOption = "选项二"
            }
            Button("取消", role: .cancel) {
                selectedOption = "操作菜单取消"
            }
        })
        // 自定义弹框动画
        .animation(.spring(response: 0.6, dampingFraction: 0.8), value: showCustomModal)
    }
}

// Sheet 视图
struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedOption: String
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("这是一个 Sheet 视图")
                    .font(.title2)
                
                Button("选择此选项") {
                    selectedOption = "Sheet 选项"
                    dismiss()
                }
                .buttonStyle(PrimaryButtonStyle())
            }
            .padding()
            .navigationTitle("Sheet 示例")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("取消") {
                        selectedOption = "Sheet 取消"
                        dismiss()
                    }
                }
            }
        }
    }
}

// 自定义弹框视图
struct CustomModalView: View {
    @Binding var isPresented: Bool
    @Binding var selectedOption: String
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 20) {
                Text("自定义弹框")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("这是一个完全自定义的弹框视图，你可以添加任何内容到这里")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                
                HStack(spacing: 15) {
                    Button("取消") {
                        selectedOption = "自定义弹框取消"
                        isPresented = false
                    }
                    .buttonStyle(SecondaryButtonStyle())
                    
                    Button("确认") {
                        selectedOption = "自定义弹框确认"
                        isPresented = false
                    }
                    .buttonStyle(PrimaryButtonStyle())
                }
                .padding(.top, 10)
            }
            .padding(30)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
            )
            .padding(.horizontal, 30)
            
            Spacer()
        }
        .background(Color.black.opacity(0.4).ignoresSafeArea())
        .onTapGesture {
            // 点击背景关闭弹框
            isPresented = false
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
