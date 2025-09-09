// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI
import UIKit
import SUtilKit_SwiftUI

public struct DialogContainerView<V: View>: View {
    @Environment(\.dialogViewController) private var holder
    @State private var appear = false
    private var _subView: I_AListener<V>
    private var _duration: TimeInterval//s
    private var _onDismissRequest: I_Listener
    
    public init(
        duration: TimeInterval = 0.2,
        onDismissRequest: @escaping I_Listener,
        @ViewBuilder _ subView: @escaping I_AListener<V>
    ){
        self._duration = duration
        self._onDismissRequest = onDismissRequest
        self._subView = subView
    }
    
    public var body: some View {
        ZStack {
            Color.black.opacity(appear ? 0.3 : 0)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: _duration)) {
                        self.appear = false
                        _onDismissRequest()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + _duration) {
                        self.holder?.dismiss(animated: true, completion: .none)
                    }
                }
            
            _subView()
                .scaleEffect(appear ? 1 : 0.5)
                .opacity(appear ? 1 : 0)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: _duration)) {
                self.appear = true
            }
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
        present(toPresent, animated: false, completion: .none)
    }
}
