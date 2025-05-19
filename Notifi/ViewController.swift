//
//  ViewController.swift
//  Notifi
//
//  Created by Deepanshu Bajaj on 19/05/25.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    private let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 30
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let appTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Notifi"
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let appImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "appImage")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let scheduleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Schedule Notification", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        // Add shadow
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.2
        return button
    }()
    
    private let backgroundButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Simulate Background", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        // Add shadow
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.2
        return button
    }()
    
    private let multipleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send Multiple Notifications", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .systemPurple
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        // Add shadow
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.2
        return button
    }()
    
    private let sequentialButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send Sequential Notifications", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .systemIndigo
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        // Add shadow
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.2
        return button
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .systemOrange
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        // Add shadow
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.2
        return button
    }()

    private var currentCount: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        verifyImages()
        setupImageTapGesture()
    }

    private func setupUI() {
        view.backgroundColor = .black
        
        // Add gradient background
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.black.cgColor,
            UIColor(white: 0.1, alpha: 1.0).cgColor
        ]
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        // Update text colors for better visibility
        appTitleLabel.textColor = .white
        
        // Add main stack view
        view.addSubview(mainStackView)
        
        // Add title and image to main stack
        mainStackView.addArrangedSubview(appTitleLabel)
        mainStackView.addArrangedSubview(appImageView)
        mainStackView.addArrangedSubview(buttonsStackView)
        
        // Add buttons to buttons stack
        buttonsStackView.addArrangedSubview(scheduleButton)
        buttonsStackView.addArrangedSubview(backgroundButton)
        buttonsStackView.addArrangedSubview(multipleButton)
        buttonsStackView.addArrangedSubview(sequentialButton)
        buttonsStackView.addArrangedSubview(resetButton)
        
        // Set constraints
        NSLayoutConstraint.activate([
            // Main stack view constraints
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // App image constraints
            appImageView.heightAnchor.constraint(equalToConstant: 200),
            appImageView.widthAnchor.constraint(equalToConstant: 200),
            
            // Button constraints
            scheduleButton.widthAnchor.constraint(equalToConstant: 280),
            scheduleButton.heightAnchor.constraint(equalToConstant: 50),
            backgroundButton.widthAnchor.constraint(equalToConstant: 280),
            backgroundButton.heightAnchor.constraint(equalToConstant: 50),
            multipleButton.widthAnchor.constraint(equalToConstant: 280),
            multipleButton.heightAnchor.constraint(equalToConstant: 50),
            sequentialButton.widthAnchor.constraint(equalToConstant: 280),
            sequentialButton.heightAnchor.constraint(equalToConstant: 50),
            resetButton.widthAnchor.constraint(equalToConstant: 280),
            resetButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Add button actions
        scheduleButton.addTarget(self, action: #selector(scheduleNotification), for: .touchUpInside)
        backgroundButton.addTarget(self, action: #selector(simulateBackground), for: .touchUpInside)
        multipleButton.addTarget(self, action: #selector(showMultipleNotificationDialog), for: .touchUpInside)
        sequentialButton.addTarget(self, action: #selector(sendSequentialNotification), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetImage), for: .touchUpInside)
        
        // Add button press animations
        [scheduleButton, backgroundButton, multipleButton, sequentialButton, resetButton].forEach { button in
            button.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
            button.addTarget(self, action: #selector(buttonTouchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        }
    }
    
    @objc private func buttonTouchDown(_ button: UIButton) {
        UIView.animate(withDuration: 0.1) {
            button.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            button.alpha = 0.9
        }
    }
    
    @objc private func buttonTouchUp(_ button: UIButton) {
        UIView.animate(withDuration: 0.1) {
            button.transform = .identity
            button.alpha = 1.0
        }
    }
    
    @objc private func resetImage() {
        // Reset the count
        currentCount = 0
        
        // Reset to original image
        UIView.transition(with: appImageView,
                         duration: 0.3,
                         options: .transitionCrossDissolve,
                         animations: {
            self.appImageView.image = UIImage(named: "appImage")
        })
    }

    @objc func scheduleNotification() {
        let alert = UIAlertController(
            title: "Send Notification",
            message: "Do you really want to send notification?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            // First update the image
            self?.updateImage(with: "bfgImageNotif")
            
            // Then schedule notification after a short delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                NotificationManager.shared.scheduleNotification()
            }
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    @objc func simulateBackground() {
        let alert = UIAlertController(
            title: "Send Notification",
            message: "Do you really want to send notification?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            // First update the image
            self?.updateImage(with: "bgImageNotif")
            
            // Then schedule background notification after a short delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                NotificationManager.shared.simulateBackground { [weak self] in
                    DispatchQueue.main.async {
                        let backgroundAlert = UIAlertController(
                            title: "Background Simulation",
                            message: "Put the app in background to see the notification in 5 seconds",
                            preferredStyle: .alert
                        )
                        backgroundAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                            // Reset badge count when OK is pressed
                            UIApplication.shared.applicationIconBadgeNumber = 0
                            print("🔄 Badge count reset to 0 (after OK pressed)")
                        })
                        self?.present(backgroundAlert, animated: true)
                    }
                }
            }
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    @objc private func showMultipleNotificationDialog() {
        let alert = UIAlertController(
            title: "Send Multiple Notifications",
            message: "Enter number of notifications (1-10)",
            preferredStyle: .alert
        )
        
        alert.addTextField { textField in
            textField.placeholder = "Enter number"
            textField.keyboardType = .numberPad
        }
        
        alert.addAction(UIAlertAction(title: "Send", style: .default) { [weak self] _ in
            guard let text = alert.textFields?.first?.text,
                  let count = Int(text),
                  count >= 1 && count <= 10 else {
                // Show error alert if input is invalid
                let errorAlert = UIAlertController(
                    title: "Invalid Input",
                    message: "Please enter a number between 1 and 10",
                    preferredStyle: .alert
                )
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(errorAlert, animated: true)
                return
            }
            
            // Schedule multiple notifications
            MultipleNotificationManager.shared.scheduleMultipleNotifications(count: count)
            
            // Show background simulation alert
            let backgroundAlert = UIAlertController(
                title: "Background Simulation",
                message: "Put the app in background to see the notifications in 2-second intervals",
                preferredStyle: .alert
            )
            backgroundAlert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                // Reset badge count when OK is pressed
                UIApplication.shared.applicationIconBadgeNumber = 0
                print("🔄 Badge count reset to 0 (after OK pressed)")
            })
            self?.present(backgroundAlert, animated: true)
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    @objc private func sendSequentialNotification() {
        let nextImageName: String
        
        // Determine next image based on current count
        switch currentCount {
        case 0:
            nextImageName = "zero"
        case 1:
            nextImageName = "one"
        case 2:
            nextImageName = "two"
        case 3:
            nextImageName = "three"
        case 4:
            nextImageName = "four"
        case 5:
            nextImageName = "five"
        case 6:
            nextImageName = "six"
        case 7:
            nextImageName = "seven"
        case 8:
            nextImageName = "eight"
        case 9:
            nextImageName = "nine"
        case 10:
            nextImageName = "ten"
        default:
            nextImageName = "appImage"
        }
        
        // Update image
        updateImage(with: nextImageName)
        
        // Schedule notification with current count
        NotificationManager.shared.scheduleSequentialNotification(imageName: nextImageName, count: currentCount)
        
        // Increment count for next press
        if currentCount < 10 {
            currentCount += 1
        }
    }
    
    private func verifyImages() {
        let imageNames = ["appImage", "bfgImageNotif", "bgImageNotif"]
        for name in imageNames {
            if let _ = UIImage(named: name) {
                print("✅ Image '\(name)' is available in assets")
            } else {
                print("❌ Image '\(name)' is NOT available in assets")
            }
        }
    }
    
    func updateImage(with name: String) {
        print("🔄 Attempting to update image to: \(name)")
        
        // Ensure we're on the main thread
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                print("❌ Self was deallocated")
                return
            }
            
            // Try to load the image
            if let image = UIImage(named: name) {
                print("✅ Successfully loaded image: \(name)")
                print("📏 Image size: \(image.size)")
                
                // Direct image update without animation first
                self.appImageView.image = image
                print("📱 Image view updated directly")
                
                // Force layout update
                self.appImageView.setNeedsDisplay()
                self.appImageView.layoutIfNeeded()
                print("🔄 Layout updated")
                
                // Now add the fade animation
                self.appImageView.alpha = 0
                UIView.animate(withDuration: 0.3) {
                    self.appImageView.alpha = 1
                }
            } else {
                print("❌ Failed to load image: \(name)")
                // Try to load the original image as fallback
                if let originalImage = UIImage(named: "appImage") {
                    self.appImageView.image = originalImage
                    print("⚠️ Reverted to original image")
                }
            }
        }
    }
    
    // Add a method to verify the current image
    func verifyCurrentImage() {
        if let currentImage = appImageView.image {
            print("📸 Current image name: \(currentImage)")
            print("📏 Current image size: \(currentImage.size)")
        } else {
            print("❌ No image currently set")
        }
    }
    
    private func setupImageTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImageTap(_:)))
        appImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleImageTap(_ gesture: UITapGestureRecognizer) {
        guard let image = appImageView.image else { return }
        let zoomVC = ImageZoomViewController(image: image)
        zoomVC.modalPresentationStyle = .fullScreen
        present(zoomVC, animated: true)
    }
} 
