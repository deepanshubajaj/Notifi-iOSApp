//
//  SplashScreen.swift
//  Notifi
//
//  Created by Deepanshu Bajaj on 19/05/25.
//

import UIKit

class SplashScreen: UIViewController {
    
    private let gifImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Notifi"
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let developerLabel: UILabel = {
        let label = UILabel()
        label.text = "Designed & Developed by: Deepanshu Bajaj"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadGIF()
        
        // Navigate to main screen after 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.navigateToMainScreen()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        // Add views
        view.addSubview(gifImageView)
        view.addSubview(appNameLabel)
        view.addSubview(developerLabel)
        
        // Set constraints
        NSLayoutConstraint.activate([
            // App name label at top
            appNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            appNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            appNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // GIF image in center
            gifImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gifImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            gifImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            gifImageView.heightAnchor.constraint(equalTo: gifImageView.widthAnchor),
            
            // Developer label at bottom
            developerLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            developerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            developerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func loadGIF() {
        if let gifURL = Bundle.main.url(forResource: "NotifGif", withExtension: "gif") {
            if let gifData = try? Data(contentsOf: gifURL) {
                gifImageView.image = UIImage.gifImageWithData(gifData)
            }
        }
    }
    
    private func navigateToMainScreen() {
        let mainVC = ViewController()
        mainVC.modalPresentationStyle = .fullScreen
        mainVC.modalTransitionStyle = .crossDissolve
        present(mainVC, animated: true)
    }
}

// Extension to handle GIF images
extension UIImage {
    static func gifImageWithData(_ data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else { return nil }
        
        let frameCount = CGImageSourceGetCount(source)
        var images: [UIImage] = []
        
        for i in 0..<frameCount {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                let image = UIImage(cgImage: cgImage)
                images.append(image)
            }
        }
        
        return UIImage.animatedImage(with: images, duration: 0.0)
    }
}
