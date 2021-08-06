//
//  StorageBoxPopUpViewController.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/19.
//

import UIKit
import Combine

final class StorageBoxPopUpViewController: UIViewController, ViewModelBindableType {
  
  var viewModel: StorageBoxPopUpViewModelType?
  
  let informationBoxView: UIView = .init(frame: .zero)
  let titleLabel: UILabel = .init(frame: .zero)
  let locationView: StorageBoxLocationView = .init(frame: .zero)
  let informationStackView: StorageBoxStackView = .init(frame: .zero)
  let closeButton: UIButton = .init(frame: .zero)
  
  private var cancellables: Set<AnyCancellable> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstraint()
    binding()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    
  }
}

private extension StorageBoxPopUpViewController {
  
  func setupView() {
    informationBoxView.backgroundColor = .bluePrimary
    informationBoxView.layer.cornerRadius = 10
    
    titleLabel.text = "보관함 이용 방법"
    titleLabel.font = .primaryBold
    titleLabel.textColor = .white
    
    closeButton.setTitle("확인", for: .normal)
    closeButton.backgroundColor = .clear
    closeButton.titleLabel?.font = .tertiaryBold
  }
  
  func setupConstraint() {
    [informationBoxView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    
    [titleLabel, locationView, informationStackView, closeButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      informationBoxView.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      informationBoxView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      informationBoxView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      
      informationBoxView.heightAnchor.constraint(equalToConstant: 520),
      informationBoxView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
      
      titleLabel.topAnchor.constraint(equalTo: informationBoxView.topAnchor, constant: 15),
      titleLabel.centerXAnchor.constraint(equalTo: informationBoxView.centerXAnchor),
      titleLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 0),
      titleLabel.heightAnchor.constraint(equalToConstant: 30),
      
      locationView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
      locationView.widthAnchor.constraint(equalTo: informationBoxView.widthAnchor, multiplier: 0.8),
      locationView.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
      locationView.heightAnchor.constraint(equalTo: informationBoxView.heightAnchor, multiplier: 0.1),
      
      informationStackView.topAnchor.constraint(equalTo: locationView.bottomAnchor, constant: 15),
      informationStackView.widthAnchor.constraint(equalTo: informationBoxView.widthAnchor, multiplier: 0.9),
      informationStackView.centerXAnchor.constraint(equalTo: locationView.centerXAnchor),
      
      closeButton.topAnchor.constraint(equalTo: informationStackView.bottomAnchor, constant: 5),
      closeButton.centerXAnchor.constraint(equalTo: informationBoxView.centerXAnchor),
      closeButton.heightAnchor.constraint(equalToConstant: 40),
      closeButton.bottomAnchor.constraint(equalTo: informationBoxView.bottomAnchor),
      closeButton.widthAnchor.constraint(equalTo: informationBoxView.widthAnchor, multiplier: 0.9)
    ])
  }
  
  func binding() {
    closeButton.tapPublisher
      .sink { [weak self] in
        self?.viewModel?.closeEvent.send()
      }
      .store(in: &cancellables)
  }
}
