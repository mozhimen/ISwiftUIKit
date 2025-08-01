// The Swift Programming Language
// https://docs.swift.org/swift-book
import Combine
import SwiftUI
import SUtilKit_SwiftUI

struct CombineDebouncedButton<L:View>: View {
    private let _action: I_Listener
    private let _label: I_AListener<L>
    private let _subject = PassthroughSubject<Void, Never>()
    private var _cancellable: AnyCancellable?
    
    //======================================================>
    
    init(interval: TimeInterval = 0.5, action: @escaping I_Listener, @ViewBuilder label: @escaping I_AListener<L>) {
        self._action = action
        self._label = label
        self._cancellable =
        _subject
            .debounce(for: .seconds(interval), scheduler: RunLoop.main)
            .sink { _ in action() }
    }
    
    //======================================================>
    
    var body: some View {
        Button.init(action: _action, label: _label)
    }
}
