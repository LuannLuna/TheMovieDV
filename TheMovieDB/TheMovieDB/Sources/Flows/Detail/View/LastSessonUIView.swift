//
//  LastSessonView.swift
//  TheMovieDB
//
//  Created by Luann Luna on 15/10/22.
//

import Combine
import SwiftUI
import UIKit

protocol LastSessonViewDelegate: AnyObject {
    func primaryButtonTapped()
}

struct LastSessonView: UIViewRepresentable {
    
    var title: String
    var subtitle: String
    var image: String
    weak var delegate: LastSessonViewDelegate?

    func makeUIView(context: Context) -> LastSessonUIView {
        LastSessonUIView()
    }

    func updateUIView(_ uiView: LastSessonUIView, context: Context) {
        uiView.setup()
        uiView.delegate = delegate
        uiView.setupTvDetails(title: title, subtitle: subtitle, image: image)
    }
}

class LastSessonUIView: UIView {
    
    var cancellable: AnyCancellable?
    @ObservedObject var imageLoader = ImageLoader()
    weak var delegate: LastSessonViewDelegate?
    
    private lazy var imageView = UIImageView().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.widthAnchor.constraint(equalToConstant: 131).isActive = true
        $0.image = UIImage(named: "placeholder")
    }
    
    private lazy var hStack = UIStackView().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 33
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    private lazy var vStack = UIStackView().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 10
        $0.distribution = .fill
    }
    
    private lazy var title = UILabel().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .white
        $0.font = UIFont.boldSystemFont(ofSize: 14.0)
    }
    
    private lazy var subtitle = UILabel().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = UIColor(Color.tertiaryColor)
        $0.font = UIFont.boldSystemFont(ofSize: 10)
    }
    
    private lazy var button = UIButton().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(Color.tertiaryColor)
        $0.setTitle("View All Sessons", for: .normal)
        $0.layer.cornerRadius = 8
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        $0.widthAnchor.constraint(equalToConstant: 120).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
        $0.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonAction() {
        delegate?.primaryButtonTapped()
    }
    
    func setupTvDetails(title: String, subtitle: String, image: String) {
        self.title.text = title
        self.subtitle.text = subtitle
        self.imageLoader.loadImage(url: image)
        cancellable = imageLoader.$downloadedData.sink { [weak self] image in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
    }
}

extension LastSessonUIView: ViewCodable {
    func setupViews() {
        addSubview(hStack)
        hStack.addArrangedSubview(imageView)
        hStack.addArrangedSubview(vStack)
        vStack.addArrangedSubview(title)
        vStack.addArrangedSubview(subtitle)
        vStack.addArrangedSubview(button)
    }
    
    func setupAnchors() {
        hStack.bindFrameToSuperviewBounds()
    }
}
