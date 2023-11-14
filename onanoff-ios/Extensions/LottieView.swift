//
//  LottieView.swift


import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {
    
    
    private let lottieFile: String
    private let lottieAnimationSpeed: CGFloat
    private let lottieLoopMode: LottieLoopMode
    
	init(lottieFile: String, lottieLoopMode: LottieLoopMode = .loop, lottieAnimationSpeed: CGFloat = 1.0) {
        self.lottieFile = lottieFile
        self.lottieLoopMode = lottieLoopMode
        self.lottieAnimationSpeed = lottieAnimationSpeed
    }
 
    let animationView = LottieAnimationView()
 
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
 
        guard let _lottieAnimation: LottieAnimation = LottieAnimation.named(lottieFile)
        else { return view }
        
        self.animationView.animation = _lottieAnimation
        self.animationView.contentMode = .scaleAspectFit
        self.animationView.animationSpeed = self.lottieAnimationSpeed
        self.animationView.loopMode = self.lottieLoopMode

        view.addSubview(self.animationView)
        self.animationView.translatesAutoresizingMaskIntoConstraints = false
        self.animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        self.animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
		self.animationView.play()
 
        return view
    }
 
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // do nothing
    }
}

