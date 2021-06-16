//
//  InspectionStandardViewController.swift
//  ZURAZU
//
//  Created by 서명렬 on 2021/06/16.
//

import UIKit
import Combine

class InspectionStandardViewController: UIViewController, ViewModelBindableType {
  
  var viewModel: InspectionStandardViewModelType?
  
  private let inspectionStandardModels: [InspectionStandardModel] = [
    InspectionStandardModel(title: "Outer", standards: [
      "본판", "플랩", "단추 구멍", "소매 트임", "안단, 안감", "앞/뒤/사이드 패널", "칼라, 스탠드, 라펠, 깃, 시보리"
    ]),
    InspectionStandardModel(title: "Top | T-Shirts", standards: [
      "본판", "겨드랑이", "소매 무릎", "소매 밑단", "네크라인(시보리, 바이어스 등)"
    ]),
    InspectionStandardModel(title: "Top | Shirts", standards: [
      "본판", "덧단", "밑단", "소매단, 뾰족단", "칼라, 라펠, 칼라밴드"
    ]),
    InspectionStandardModel(title: "Top | Knit", standards: [
      "본판", "시보리", "팔꿈치"
    ]),
    InspectionStandardModel(title: "Pants", standards: [
      "본판", "주머니", "밑단(헤짐)", "밑둘레(마모, 튿어짐 등)", "허리단(늘어남, 벨트고리 등)"
    ]),
    InspectionStandardModel(title: "Skirt", standards: [
      "본판", "안감", "밑단, 겹트임", "허리단(늘어남, 벨트고리 등)"
    ]),
    InspectionStandardModel(title: "OnePiece", standards: [
      "본판", "소매단", "앞/뒤/사이드 패널", "네크라인, 칼라, 라펠, 칼라밴드"
    ]),
    InspectionStandardModel(title: "검수 항목", standards: [
      "냄새", "마모", "보풀", "늘어남", "봉제 불량", "변색, 이염", "수선/리폼 여부", "오염(생활 얼룩)", "구성품(원피스 허리끈 벨트 등)", "지퍼, 단추, 후크, 밴드 등 부자재"
    ])
  ]
  
  private lazy var backButton: UIButton = {
    let button = UIButton(frame: .zero)
    button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
    button.tintColor = .monoPrimary
    
    return button
  }()
  
  private let tableView: InspectionStandardTableView = .init(frame: .zero, style: .plain)
  
  private var cancellables: Set<AnyCancellable> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupConstraint()
  }
  
  func bindViewModel() {
    backButton.tapPublisher
      .sink { [weak self] in
        self?.viewModel?.closeEvent.send()
      }
      .store(in: &cancellables)
  }
  
}

private extension InspectionStandardViewController {
  
  func setupView() {
    title = "검수 기준"
    let leftButtonItem: UIBarButtonItem = .init(customView: backButton)
    navigationItem.leftBarButtonItem = leftButtonItem
    
    tableView.dataSource = self
  }
  
  func setupConstraint() {
    [tableView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
}

extension InspectionStandardViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    inspectionStandardModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: InspectionStandardTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
    
    cell.updateCell(with: inspectionStandardModels[indexPath.row])
    
    return cell
  }
}
