//
//  Util.swift
//  ISwiftUIKit.Flow
//
//  Created by Taiyou on 2025/8/7.
//

extension Sequence {
    @inlinable
    func adjacentPairs() -> some Sequence<(Element, Element)> {
        zip(self, self.dropFirst())
    }

    @inlinable
    func sum<Result: Numeric>(of block: (Element) -> Result) -> Result {
        reduce(into: .zero) { $0 += block($1) }
    }
}
