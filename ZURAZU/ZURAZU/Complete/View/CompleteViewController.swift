//
//  CompleteViewController.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/17.
//

import UIKit

class CompleteViewController: UIViewController {
  
  let homeImageView: UIImageView = .init(frame: .zero)
  let guideLabel: UILabel = .init(frame: .zero)
  let homeButton: UIButton = .init(frame: .zero)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstraint()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    tabBarController?.tabBar.isHidden = true
  }
  
  func updateGuideText(with text: String) {
    let attributedString: NSMutableAttributedString = .init(string: text)
    let paragraphStyle: NSMutableParagraphStyle = .init()
    
    paragraphStyle.lineSpacing = 15
    paragraphStyle.alignment = .center
    paragraphStyle.lineBreakMode = .byWordWrapping
    
    if #available(iOS 14.0, *) {
      paragraphStyle.lineBreakStrategy = .hangulWordPriority
    }
    
    attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
    
    guideLabel.attributedText = attributedString
  }
}

private extension CompleteViewController {
  
  func setupView() {
    homeImageView.image = UIImage(named: "home-logo")
    homeImageView.contentMode = .scaleAspectFit

    guideLabel.textColor = .bluePrimary
    guideLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
    guideLabel.numberOfLines = 0
    
    homeButton.backgroundColor = .bluePrimary
    homeButton.setTitle("홈으로 이동", for: .normal)
    homeButton.setTitleColor(.white, for: .normal)
    homeButton.titleLabel?.font = .secondaryBold
    
    navigationItem.hidesBackButton = true
  }
  
  func setupConstraint() {
    [homeImageView, guideLabel, homeButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      homeImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33),
      homeImageView.heightAnchor.constraint(equalTo: homeImageView.widthAnchor),
      homeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
      homeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      guideLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
      guideLabel.topAnchor.constraint(equalTo: homeImageView.bottomAnchor, constant: 25),
      guideLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      homeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
      homeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
      homeButton.heightAnchor.constraint(equalToConstant: 52),
      homeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    
  }
}
