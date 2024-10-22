//
//  Extension+View.swift
//  WatchList
//
//  Created by Jonni Akesson on 2024-09-27.
//

import SwiftUI

// MARK: - Custom Alert
extension View {
    func customAlert<T: CustomAlertError>(
        errorBinding: Binding<T?>,
        primaryAction: @escaping () -> Void,
        secondaryAction: (() -> Void)? = nil
    ) -> some View {
        self.alert(errorBinding.wrappedValue?.title ?? "",
                   isPresented: Binding(value: errorBinding),
                   presenting: errorBinding.wrappedValue,
                   actions: { error in
            Button(error.primaryButtonLabel) {
                primaryAction()
            }
            Button(role: .cancel) {
                secondaryAction?()
            } label: {
                Text(error.cancelButtonLabel)
            }
        }, message: { error in
            Text(error.message)
        })
    }
}
// MARK: - Custom Progress View Overlay
extension View {
    func customProgressViewOverlay(isLoading: Bool) -> some View {
        self.overlay {
            if isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(1.8)
            }
        }
    }
}
// MARK: - Custom Toggle Button
extension View {
    func customToggleButton(
        isSelected: Bool,
        selectedImageName: String = "star.fill",
        imageName: String = "star",
        selectedForegroundColor: Color = .accentColor,
        foregroundOffColor: Color = .gray.opacity(0.5),
        fontSize: CGFloat = 17,
        action: @escaping () -> Void
    ) -> some View {
        Image(systemName: isSelected ? selectedImageName : imageName)
            .foregroundColor(isSelected ? selectedForegroundColor : foregroundOffColor)
            .font(Font.system(size: fontSize))
            .onTapGesture {
                action()
            }
    }
}
// MARK: - Custom Toolbar Toggle Button
extension View {
    func customToolbarToggleButton(
        toggleBinding: Binding<Bool>,
        placement: ToolbarItemPlacement = .topBarTrailing,
        selectedImageName: String = "star.fill",
        imageName: String = "star",
        selectedForegroundColor: Color = .accentColor,
        foregroundColor: Color = .gray.opacity(0.5)
    ) -> some View {
        self.toolbar {
            ToolbarItem(placement: placement) {
                Button(action: {
                    withAnimation {
                        toggleBinding.wrappedValue.toggle()
                    }
                }) {
                    Image(systemName: toggleBinding.wrappedValue ? selectedImageName : imageName)
                        .fontWeight(.semibold)
                        .font(.body)
                        .foregroundColor(toggleBinding.wrappedValue ? selectedForegroundColor : foregroundColor)
                }
            }
        }
    }
}
// MARK: - Custom Phase Animator
private enum AnimationPhase: CaseIterable {
    case initial
    case move
    case scale

    var verticalOffset: Double {
        switch self {
        case .initial: 0
        case .move, .scale: -10
        }
    }
    var scaleEffect: Double {
        switch self {
        case .initial: 1
        case .move, .scale: 1.5
        }
    }
}
extension View {
    func customPhaseAnimation(startAnimation: Bool) -> some View {
        self.phaseAnimator(AnimationPhase.allCases, trigger: startAnimation) { content, phase in
            content
                .scaleEffect(phase.scaleEffect)
                .offset(y: phase.verticalOffset)
        } animation: { phase in
            switch phase {
            case .initial: .smooth
            case .move: .easeInOut(duration: 0.3)
            case .scale: .spring(duration: 0.3, bounce: 0.7)
            }
        }
    }
}
