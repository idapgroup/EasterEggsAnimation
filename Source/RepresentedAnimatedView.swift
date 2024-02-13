//
//  RepresentedAnimatedView.swift
//  DiagonalAnimationSwiftUI
//
//  Created by Alexander Ermakov on 12.02.2024.
//  Copyright © 2024 IDAP. All rights reserved.
	

import SwiftUI

public struct RepresentedAnimatedView: UIViewRepresentable {
    
    // MARK: -
    // MARK: Bindings
    
    @Binding private var currentOffset: CGPoint
    
    // MARK: -
    // MARK: Variables
    
    private let context: AnimatedView
    
    // MARK: -
    // MARK: Initializations
    
    init(patternImage: UIImage?, divider: CGFloat = 1000, dates: [String] = [], offset: Binding<CGPoint>) {
        self.context = AnimatedView(patternImage: patternImage, divider: divider, dates: dates)
        _currentOffset = offset
    }
    
    // MARK: -
    // MARK: Public functions
    
    public func animate() {
        self.context.animate()
    }
    
    // MARK: -
    // MARK: UIViewRepresentable Requirements
    
    public func makeUIView(context: Context) -> AnimatedView {
        return self.context
    }
    
    public func updateUIView(_ uiView: AnimatedView, context: Context) {
        uiView.xOffset = self.currentOffset.x
        uiView.yOffset = self.currentOffset.y
    }
}
