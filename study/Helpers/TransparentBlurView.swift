//
//  TransparentBlurView.swift
//  study
//
//  Created by Dursun YILDIZ on 30.07.2023.
//

import SwiftUI
struct TransparentBlurView: UIViewRepresentable {
    var removeAllFilters: Bool = false
    func makeUIView(context _: Context) -> TransparentBlurViewHelper {
        TransparentBlurViewHelper(removeAllFilters: removeAllFilters)
    }

    func updateUIView(_: TransparentBlurViewHelper, context _: Context) {}
}

final class TransparentBlurViewHelper: UIVisualEffectView {
    init(removeAllFilters: Bool) {
        super.init(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        if subviews.indices.contains(1) {
            subviews[1].alpha = 0
        }
        if let backdropLayer = layer.sublayers?.first {
            if removeAllFilters {
                backdropLayer.filters = []
            } else {
                /// Removing All Expect Blur Filter
                backdropLayer.filters?.removeAll(where: { filter in
                    String(describing: filter) != "gaussianBlur"
                })
            }
        }
    }

    override func traitCollectionDidChange(_: UITraitCollection?) {}

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
