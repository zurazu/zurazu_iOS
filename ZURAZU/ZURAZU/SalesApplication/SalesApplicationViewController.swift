//
//  SalesApplicationViewController.swift
//  ZURAZU
//
//  Created by 최동규 on 2021/05/25.
//

import UIKit
import Combine
import CombineDataSources
import CombineCocoa

final class SalesApplicationViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  private let imagePicker = UIImagePickerController()
  private var currentImageIndex = 0
  
  private let model: [SalesApplicationSectionModel] = [
    SalesApplicationSectionPickerModel(title: "카테고리", isNecessary: true, items: ["Outer", "TOP | T-Shirts", "TOP | Shirts", "TOP | Knit", "Pants", "Skirt", "Onepeice"]),
    SalesApplicationSectionInputModel(title: "브랜드 및 구매처", placeHolder: "6자리 이상으로 입력해주세요"),
    SalesApplicationSectionInputModel(title: "구매 가격", subTitle: "구매 가격을 적으시면 보다 정확한 판매가 산출이 가능합니다.", height: 55),
    SalesApplicationSectionInputModel(title: "희망 판매 가격"),
    SalesApplicationSectionPickerModel(title: "사이즈", isNecessary: false, items: ["S", "M", "L", "Free", "모름"]),
    SalesApplicationSectionPickerModel(title: "착용 횟수", isNecessary: true, items: ["1", "2", "3", "4", "모름"]),
    SalesApplicationSectionPictureModel(title: "상품 사진", subtitle: "제출된 사진은 상품의 상태를 점검하는 용도로만 쓰이며,\n실제 상품 상세컷은 주라주에서 자체 촬영한 사진으로 업로드됩니다.", headerHeight: 70, isNecessary: true)]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.visibleCells.forEach {
      let cell: InputCollectionViewCell? = $0 as? InputCollectionViewCell
      cell?.textField.setNeedsDisplay()
    }
  }
}

extension SalesApplicationViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if model[section].style != .picture {
      return 1
    }
    return 5
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return model.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let sectionStyle: SalesApplicationSectionStyle = model[indexPath.section].style
    switch sectionStyle {
    case .input:
      guard let cell: InputCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "InputCollectionViewCell", for: indexPath) as? InputCollectionViewCell
      else { return UICollectionViewCell() }
      
      cell.textField.delegate = self
      let inputModel: SalesApplicationSectionInputModel? = model[indexPath.section] as? SalesApplicationSectionInputModel
      cell.updatePlaceHolder(message: inputModel?.placeHolder)
      cell.updateDescriptionLabel(message: inputModel?.description)
      
      cell.textField.returnPublisher.sink { _ in
        cell.textField.resignFirstResponder()
      }.store(in: &cell.cancellables)
      
      cell.textField.textPublisher.sink { text in
        inputModel?.content = text ?? ""
      }.store(in: &cell.cancellables)
      return cell
      
    case .picker:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PickerCollectionViewCell", for: indexPath) as? PickerCollectionViewCell
      else { return UICollectionViewCell() }
      let inputModel: SalesApplicationSectionPickerModel? = model[indexPath.section] as? SalesApplicationSectionPickerModel
      let pickerView: UIPickerView = .init()
      pickerView.delegate = self
      pickerView.tag = indexPath.section
      cell.textField.inputView = pickerView
      
      cell.textField.textPublisher.sink { text in
        inputModel?.content = text ?? ""
      }.store(in: &cell.cancellables)
      
      return cell
      
    case .picture:
      guard let cell: PictureCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCollectionViewCell", for: indexPath) as? PictureCollectionViewCell
      else { return UICollectionViewCell() }
      let pictureModel: SalesApplicationSectionPictureModel? = model[indexPath.section] as? SalesApplicationSectionPictureModel
      
      cell.tag = indexPath.item
      cell.borderImageView.image = pictureModel?.images[indexPath.item]
      cell.delegate = self
      return cell
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    guard model[indexPath.section].style == .picture else {
      return CGSize(width: collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right, height: model[indexPath.section].height)
    }
    
    let spacing: CGFloat = (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
    let length: CGFloat = ((collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right) / 3) - (spacing * 2)
    
    return CGSize(width: length, height: length)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    
    return CGSize(width: collectionView.bounds.width, height: model[section].headerHeight)
  }
  
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    switch kind {
    case UICollectionView.elementKindSectionHeader:
      guard let headerView = collectionView
              .dequeueReusableSupplementaryView(ofKind: kind,
                                                withReuseIdentifier: SalesApplicationSectionHeader.identifier,
                                                for: indexPath) as? SalesApplicationSectionHeader else { return UICollectionReusableView()
      }
      
      headerView.updateTitleLabelText(model[indexPath.section].title)
      headerView.updateSubtitleLabelText(model[indexPath.section].subtitle)
      headerView.isNecessary = model[indexPath.section].isNecessary
      
      return headerView
      
    default:
      return UICollectionReusableView()
    }
  }
}

extension SalesApplicationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return (model[pickerView.tag] as? SalesApplicationSectionPickerModel)?.items.count ?? 0
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return (model[pickerView.tag] as? SalesApplicationSectionPickerModel)?.items[row] ?? ""
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let indexPath: IndexPath = .init(row: 0, section: pickerView.tag)
    guard let cell: PickerCollectionViewCell = collectionView.cellForItem(at: indexPath) as? PickerCollectionViewCell else { return }
    
    cell.textField.text = (model[pickerView.tag] as? SalesApplicationSectionPickerModel)?.items[row] ?? ""
    cell.textField.resignFirstResponder()
  }
}

extension SalesApplicationViewController: UITextFieldDelegate {
  
}

extension SalesApplicationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image: UIImage = info[.originalImage] as? UIImage else { return }
    (model.last as? SalesApplicationSectionPictureModel)?.images[currentImageIndex] = image
    picker.dismiss(animated: true, completion: nil)
    collectionView.reloadData()
  }
  
  
}

extension SalesApplicationViewController: PictureCollectionViewCellDelegate {
  
  func tapImageView(_ cell: PictureCollectionViewCell) {
    
    imagePicker.delegate = self
    imagePicker.sourceType = .savedPhotosAlbum
    imagePicker.allowsEditing = false
    currentImageIndex = cell.tag
    
    present(imagePicker, animated: true, completion: nil)
  }
  
}

private extension SalesApplicationViewController {
  
  func setupView() {
    collectionView.contentInset = .init(top: 0, left: 26, bottom: 13, right: 26)
    let layout: UICollectionViewFlowLayout? = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
    layout?.sectionInset = .init(top: 0, left: 0, bottom: 22, right: 0)
    layout?.minimumInteritemSpacing = 5
    navigationItem.setLeftBarButton(UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancel(sender: ))), animated: false)
    navigationItem.setRightBarButton(UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(sendInformationToServer(sender:))), animated: false)
    title = "판매 신청"
    collectionView.delegate = self
    collectionView.dataSource = self
    
    collectionView.register(InputCollectionViewCell.self, forCellWithReuseIdentifier: "InputCollectionViewCell")
    collectionView.register(PickerCollectionViewCell.self, forCellWithReuseIdentifier: "PickerCollectionViewCell")
    collectionView.register(PictureCollectionViewCell.self, forCellWithReuseIdentifier: "PictureCollectionViewCell")
    
    collectionView.register(SalesApplicationSectionHeader.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: SalesApplicationSectionHeader.identifier)
  }
  
  
  @objc func sendInformationToServer(sender: UITapGestureRecognizer) {
    // MARK: - 주문완료 테스트) 임의의 데이터 넣어주는 부분입니다. 수정해야합니다.
//
//    let product = OrderCompletedProduct(
//      orderedUserInformation: "주라주 000-0000-0000",
//      productInformation: "[브랜드 없음] 검은색 자켓",
//      price: 29850,
//      depositAccountNumber: "주라주 | 국민은행 110-1234-56789"
//    )
    SceneCoordinator.shared.transition(scene: SalesApplicationScene(), using: .push, animated: true)
  }
  
  @objc func cancel(sender: UITapGestureRecognizer) {
    SceneCoordinator.shared.close(animated: true)
  }
}
