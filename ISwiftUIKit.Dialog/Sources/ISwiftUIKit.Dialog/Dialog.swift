// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI
import UIKit
import SUtilKit_SwiftUI

public struct DialogActions {
    public let appear: I_Listener
    public let disappear: I_Listener
    public let dismiss: IA_Listener<Bool>
}

public struct DialogContainerView<V:View>: View {
    @Environment(\.dialogViewController) private var holder
    @State private var isShowing = false
    private var _subView: IA_BListener<DialogActions,V>
    private var duration: TimeInterval//s
    private var _onDismissRequest: I_Listener
    
    public init(
        duration: TimeInterval = 0.2,
        onDismissRequest: @escaping I_Listener,
        @ViewBuilder content: @escaping IA_BListener<DialogActions,V>
    ){
        self.duration = duration
        self._onDismissRequest = onDismissRequest
        self._subView = content
    }
    
    public var body: some View {
        ZStack {
            Color.black.opacity(isShowing ? 0.3 : 0)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    _onDismissRequest()
                    disappear()
                    dismiss(animated: false)
                }
            
            _subView(DialogActions(appear: appear,disappear: disappear,dismiss: dismiss))
                .scaleEffect(isShowing ? 1 : 0.5)
                .opacity(isShowing ? 1 : 0)
        }
        .onAppear(perform: {
            appear()
        })
    }
    
    public func appear() {
        withAnimation(.easeInOut(duration: duration)) {
            self.isShowing = true
        }
    }
    
    public func disappear(){
        withAnimation(.easeInOut(duration: duration)) {
            self.isShowing = false
        }
    }
    
    public func dismiss(animated: Bool){
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.holder?.dismiss(animated: animated, completion: .none)
        }
    }
}

public struct DialogViewControllerHolder {
    public weak var value: UIViewController?
}

public struct DialogViewControllerHolderKey: @preconcurrency EnvironmentKey {
    @MainActor
    public static var defaultValue: DialogViewControllerHolder {
        return DialogViewControllerHolder(value: UIApplication.shared.windows.first?.rootViewController)
    }
}

public extension EnvironmentValues {
    var dialogViewController: UIViewController? {
        get { return self[DialogViewControllerHolderKey.self].value }
        set { self[DialogViewControllerHolderKey.self].value = newValue }
    }
}

public extension UIViewController {
    func present<Content: View>(@ViewBuilder builder: () -> Content){
        let toPresent = UIHostingController(rootView: AnyView(EmptyView()))
        toPresent.modalPresentationStyle = .overCurrentContext
        toPresent.modalTransitionStyle = .crossDissolve
        toPresent.view.backgroundColor = .clear
        toPresent.rootView = AnyView(builder().environment(\.dialogViewController, toPresent))
        self.present(toPresent, animated: false, completion: .none)
    }
    
    func dismiss(duration:TimeInterval){
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.dismiss(animated: true, completion: .none)
        }
    }
}
