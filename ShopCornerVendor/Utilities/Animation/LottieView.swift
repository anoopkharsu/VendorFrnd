//
//  LottieView.swift
//  ShopCorner
//
//  Created by Anoop Kharsu on 18/02/25.
//


import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var animationName: String

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView(name: animationName)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) { }
}

struct ContentView: View {
    var body: some View {
        LottieView(animationName: "shimmer")
            .frame(width: 300, height: 100)
    }
}
