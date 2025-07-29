// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI

public struct StarRating: View {
    let rating: CGFloat
    let maxRating: Int
    let coverColor: Color
    let defaultColor: Color
    
    public init(rating: CGFloat, maxRating: Int, coverColor: Color = .yellow, defaultColor: Color = .gray) {
        self.rating = rating
        self.maxRating = maxRating
        self.coverColor = coverColor
        self.defaultColor = defaultColor
    }

    public var body: some View {
        let stars = HStack(spacing: 0) {
            ForEach(0..<maxRating, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }

        stars.overlay(
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: rating / CGFloat(maxRating) * geometry.size.width)
                        .foregroundColor(coverColor)
                }
            }
            .mask(stars)
        )
        .foregroundColor(defaultColor)
    }
}

#Preview {
    StarRating(rating: 3.4, maxRating: 5)
}
