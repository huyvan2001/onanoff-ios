//
//  ScrollableView.swift
//  DescendantsDNA
//
//  Created by Dmytro Davydenko on 16/08/2023.
//

import SwiftUI

class ZoomableImageUIView: UIView, UIScrollViewDelegate {
    
    static let kMaximumZoomScale: CGFloat = 6.0
    static let kMinimumZoomScale: CGFloat = 1.0
    
    private var onSingleTapGesture: ((UITapGestureRecognizer) -> Void)?

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.bouncesZoom = true
        scrollView.maximumZoomScale = self.maximumZoomScale
        scrollView.minimumZoomScale = ZoomableImageUIView.kMinimumZoomScale
        #if !os(tvOS)
        scrollView.isMultipleTouchEnabled = true
        #endif
        scrollView.delegate = self
        #if !os(tvOS)
        scrollView.scrollsToTop = false
        scrollView.backgroundColor = UIColor(Color.Primary_400)
        #endif
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.delaysContentTouches = false
        scrollView.canCancelContentTouches = true
        scrollView.alwaysBounceVertical = false
        scrollView.contentInsetAdjustmentBehavior = .never
        self.addSubview(scrollView)
        return scrollView
    }()
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.clipsToBounds = true
        containerView.backgroundColor = UIColor(Color.Primary_400)
        containerView.contentMode = .scaleAspectFill
        scrollView.addSubview(containerView)
        return containerView
    }()

    private lazy var swiftView: UIView = {
        let imageView = UIImageView(frame: containerView.bounds) // Sử dụng kích thước của containerView
        imageView.backgroundColor = UIColor(Color.Primary_400)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        containerView.addSubview(imageView)
        return imageView
    }()
    
    
    private lazy var maximumZoomScale: CGFloat = {
        return ZoomableImageUIView.kMaximumZoomScale
    }()
    
    init(frame: CGRect, maximumZoomScale: CGFloat = 15.0, onSingleTapGesture: ((UITapGestureRecognizer) -> Void)? = nil) {
        super.init(frame: frame)
        
        self.maximumZoomScale = maximumZoomScale
        self.onSingleTapGesture = onSingleTapGesture
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(onSingleTap(tap:)))
        self.addGestureRecognizer(singleTap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(onDoubleTap(tap:)))
        doubleTap.numberOfTapsRequired = 2
        singleTap.require(toFail: doubleTap)
        containerView.addGestureRecognizer(doubleTap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(uiView: UIView) {
        self.swiftView = uiView
        recoverSubviews()
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        super.updateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        recoverSubviews()
    }
    
    @objc
    func onSingleTap(tap: UITapGestureRecognizer) {
        guard let onSingleTapGesture = onSingleTapGesture else { return }
        onSingleTapGesture(tap)
    }
    
    @objc
    func onDoubleTap(tap: UITapGestureRecognizer) {
        if (scrollView.zoomScale > 1.0) {
            scrollView.contentInset = .zero
            scrollView.setZoomScale(1.0, animated: true)
        } else {
            let touchPoint: CGPoint = tap.location(in: self.swiftView)
            let newZoomScale: CGFloat = scrollView.maximumZoomScale
            let sizeWidth: CGFloat = UIScreen.main.bounds.size.width / newZoomScale
            let sizeHeight: CGFloat = UIScreen.main.bounds.size.height / newZoomScale
            scrollView.zoom(to: CGRect(x: touchPoint.x - sizeWidth / 2.0,
                                       y: touchPoint.y - sizeHeight / 2.0,
                                       width: sizeWidth,
                                       height: sizeHeight),
                            animated: true)
        }
    }
    
    func recoverSubviews() {
        scrollView.setZoomScale(1.0, animated: false)
        resizeSubviews()
    }
    
    func resizeSubviews() {
        containerView.frame.size = self.bounds.size
        containerView.center = CGPoint(x: self.bounds.width / 2.0, y: self.bounds.height / 2.0)
        
        let containerWidth: CGFloat = swiftView.bounds.size.width
        let containerHeight: CGFloat = swiftView.bounds.size.height
        
        if (containerWidth / containerHeight > self.bounds.size.width / self.bounds.size.height * 3) {
            // 超宽图
            containerView.frame.size.width = self.bounds.size.width
            containerView.frame.size.height = containerView.bounds.size.width / containerWidth * containerHeight
            
            scrollView.maximumZoomScale = self.bounds.size.height / containerView.bounds.size.height
            
            let contentSizeWidth: CGFloat = max(containerView.bounds.size.width, self.bounds.size.width)
            scrollView.contentSize = CGSize(width: contentSizeWidth, height: self.bounds.size.height)
            
            containerView.center.y = self.bounds.size.height / 2.0
            containerView.center.x = self.bounds.size.width / 2.0
        } else if (containerHeight / containerWidth > self.bounds.size.height / self.bounds.size.width * 3) {
            // 超高图
            containerView.frame.size.height = self.bounds.size.height
            containerView.frame.size.width = containerView.bounds.size.height / containerHeight * containerWidth
            
            scrollView.maximumZoomScale = self.bounds.size.width / containerView.bounds.size.width
            
            let contentSizeHeight: CGFloat = max(containerView.bounds.size.height, self.bounds.size.height)
            scrollView.contentSize = CGSize(width: self.bounds.size.width, height: contentSizeHeight)
            
            containerView.center.y = self.bounds.size.height / 2.0
            containerView.center.x = self.bounds.size.width / 2.0
        } else {
            if ((containerWidth / containerHeight) > (self.bounds.size.width / self.bounds.size.height)) {
                // 左右对齐
                containerView.frame.size.width = self.bounds.size.width
                
                var height: CGFloat = containerHeight / containerWidth * self.bounds.size.width
                if (height < 1 || height.isNaN) { height = self.bounds.size.height }
                height = floor(height)
                containerView.frame.size.height = height
                
                let contentSizeHeight: CGFloat = max(containerView.bounds.size.height, self.bounds.size.height)
                scrollView.contentSize = CGSize(width: self.bounds.size.width, height: contentSizeHeight)
                
                containerView.center.y = self.bounds.size.height / 2.0
                containerView.center.x = self.bounds.size.width / 2.0
            } else {
                // 上下对齐
                containerView.frame.size.height = self.bounds.size.height
                
                var width = containerWidth / containerHeight * self.bounds.size.height
                if (width < 1 || width.isNaN) { width = self.bounds.size.width }
                width = floor(width)
                containerView.frame.size.width = width
                
                let contentSizeWidth: CGFloat =  max(containerView.bounds.size.width, self.bounds.size.width)
                scrollView.contentSize = CGSize(width: contentSizeWidth, height: self.bounds.size.height)
                
                containerView.center.y = self.bounds.size.height / 2.0
                containerView.center.x = self.bounds.size.width / 2.0
            }
            scrollView.maximumZoomScale = self.maximumZoomScale
        }
        scrollView.scrollRectToVisible(self.bounds, animated: false)
        scrollView.alwaysBounceVertical = containerView.bounds.size.height > self.bounds.size.height
        swiftView.frame = containerView.frame
    }
    
    func refreshcontainerViewCenter() {
        let offsetX: CGFloat = (scrollView.bounds.size.width > scrollView.contentSize.width) ? ((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5) : 0.0
        let offsetY: CGFloat = (scrollView.bounds.size.height > scrollView.contentSize.height) ? ((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5) : 0.0
        containerView.center = CGPoint(x: scrollView.contentSize.width * 0.5 + offsetX, y: scrollView.contentSize.height * 0.5 + offsetY)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return containerView
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollView.contentInset = .zero
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        refreshcontainerViewCenter()
    }
}


public struct ZoomableImageView<Content: View>: View {
    var content: () -> Content
    
    var onSingleTapGesture: ((UITapGestureRecognizer) -> Void)?
    var maximumZoomScale: CGFloat
    /// Create a ZoomableImageView.
    /// - Parameters:
    ///   - image: The image to show.
    ///   - maximumZoomScale: The maximum zoomScale you can zoom-in the image. Default: 3.
    ///   - onSingleTapGesture: The callback action when the imageView on single tap gesture.
    public init(maximumZoomScale: CGFloat = 15.0, onSingleTapGesture: ((UITapGestureRecognizer) -> Void)? = nil,@ViewBuilder _ content: @escaping () -> Content) {
        self.maximumZoomScale = maximumZoomScale
        self.onSingleTapGesture = onSingleTapGesture
        self.content = content
    }
    
    public var body: some View {
        Representable(content: content(), maximumZoomScale: maximumZoomScale, frame: .zero, onSingleTapGesture: onSingleTapGesture)
            .background(
                Color.Primary_400.ignoresSafeArea()
            )
    }
}

extension ZoomableImageView where Content: View {
    typealias ViewRepresentable = UIViewRepresentable
    
    struct Representable: ViewRepresentable {
        typealias UIViewType = ZoomableImageUIView
        
        let content: Content
        let maximumZoomScale: CGFloat
        let frame: CGRect
        var onSingleTapGesture: ((UITapGestureRecognizer) -> Void)?
        
        func makeUIView(context: Context) -> ZoomableImageUIView {
            return ZoomableImageUIView(frame: frame, maximumZoomScale: maximumZoomScale, onSingleTapGesture: onSingleTapGesture)
        }
        
        func updateUIView(_ uiView: ZoomableImageUIView, context: Context) {
            let hosting = UIHostingController(rootView: content)
            hosting.view.frame = uiView.bounds
            uiView.containerView.addSubview(hosting.view)
            uiView.updateView(uiView: hosting.view)
        }
    }
}
