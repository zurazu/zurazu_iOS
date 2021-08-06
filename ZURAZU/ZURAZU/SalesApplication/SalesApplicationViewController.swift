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

final class SalesApplicationViewController: UIViewController, ViewModelBindableType {
  
  var viewModel: SalesApplicationViewModelType?
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  private let imagePicker = UIImagePickerController()
  private var currentImageIndex = 0
  private var cancellables: Set<AnyCancellable> = []
  private var keyboardSize: CGRect = .init(x: 0, y: 0, width: 0, height: UIScreen.main.bounds.height * 0.3)
  
  private let model: [SalesApplicationSectionModel] = [
    SalesApplicationSectionPickerModel(title: "카테고리", isNecessary: true, items: ["Outer", "TOP | T-Shirts", "TOP | Shirts", "TOP | Knit", "Pants", "Skirt", "Onepeice"]),
    SalesApplicationSectionInputModel(title: "브랜드 및 구매처", placeHolder: "6자리 이상으로 입력해주세요"),
    SalesApplicationSectionInputModel(title: "구매 가격", subTitle: "구매 가격을 적으시면 보다 정확한 판매가 산출이 가능합니다.", height: 55),
    SalesApplicationSectionInputModel(title: "희망 판매 가격"),
    SalesApplicationSectionPickerModel(title: "사이즈", isNecessary: false, items: ["S", "M", "L", "Free", "모름"]),
    SalesApplicationSectionPickerModel(title: "착용 횟수", isNecessary: true, items: ["0~1회", "2~5회", "6~15회", "16회이상", "모름"]),
    SalesApplicationSectionPictureModel(title: "상품 사진", subtitle: "제출된 사진은 상품의 상태를 점검하는 용도로만 쓰이며,\n실제 상품 상세컷은 주라주에서 자체 촬영한 사진으로 업로드됩니다.", headerHeight: 70, isNecessary: true),
    SalesApplicationSectionCommentModel(title: "상세설명 ", placeHolder: "키 165에 엉덩이 덮는 기장입니다.", height: 166, isNecessary: false)]
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    tabBarController?.tabBar.isHidden = true
    viewModel?.startEvent.send()
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    tabBarController?.tabBar.isHidden = false
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.visibleCells.forEach {
      let cell: InputCollectionViewCell? = $0 as? InputCollectionViewCell
      cell?.textField.setNeedsDisplay()
    }
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
  }
}

private extension SalesApplicationViewController {
  
  @objc func keyboardWillShow(_ notification: Notification) {
    if let userInfo = notification.userInfo {
      keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
    }
  }
}

extension SalesApplicationViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if model[section].style != .picture {
      return 1
    }
    return 3
  }
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    view.endEditing(true)
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
      
      cell.textField.returnPublisher
        .sink {
          if indexPath.section == 1 || indexPath.section == 2 {
            guard let nextCell = collectionView.cellForItem(at: IndexPath(row: indexPath.row, section: indexPath.section + 1)) as? InputCollectionViewCell
            else { return }
            nextCell.textField.becomeFirstResponder()

            return
          }

          cell.textField.resignFirstResponder()
        }
        .store(in: &cancellables)
      
      cell.textField.delegate = self
      cell.textField.tag = indexPath.section
      let inputModel: SalesApplicationSectionInputModel? = model[indexPath.section] as? SalesApplicationSectionInputModel
      cell.updatePlaceHolder(message: inputModel?.placeHolder)
      cell.updateDescriptionLabel(message: inputModel?.description)
      
      cell.textField.text = inputModel?.content
      
      cell.textField.textPublisher.sink { [weak self] text in
        inputModel?.content = text ?? ""
        self?.isValid()
      }.store(in: &cell.cancellables)
      return cell
      
    case .picker:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PickerCollectionViewCell", for: indexPath) as? PickerCollectionViewCell
      else { return UICollectionViewCell() }
      let pickerModel: SalesApplicationSectionPickerModel? = model[indexPath.section] as? SalesApplicationSectionPickerModel
      let pickerView: UIPickerView = .init()
      
      cell.textField.text = pickerModel?.content
      pickerView.delegate = self
      pickerView.tag = indexPath.section
      cell.textField.inputView = pickerView
      
      let selectButton = UIBarButtonItem()
      selectButton.title = "선택"
      selectButton.tintColor = .systemBlue
      selectButton.target = self
      selectButton.tapPublisher.sink { [weak self] _ in
        if pickerView.tag == 0 {
          cell.textField.resignFirstResponder()
          let row = pickerView.selectedRow(inComponent: 0)
//          cell.textField.text = pickerModel?.items[row] ?? ""
          cell.textField.text = self?.viewModel?.subCategories.value[row].korean
          pickerModel?.content = cell.textField.text ?? ""
          self?.isValid()
          return
        }
        
        cell.textField.resignFirstResponder()
        let row = pickerView.selectedRow(inComponent: 0)
        cell.textField.text = pickerModel?.items[row] ?? ""
        pickerModel?.content = cell.textField.text ?? ""
        self?.isValid()
      }.store(in: &cell.cancellables)
      
      
      
      
      let  toolbar = UIToolbar()
      
      toolbar.tintColor = .darkGray
      
      toolbar.frame = CGRect(x: 0, y: 0, width: 0, height: 35)
      toolbar.setItems([selectButton], animated: true)
      
      cell.textField.textPublisher.sink { [weak self] text in
        pickerModel?.content = text ?? ""
        self?.isValid()
      }.store(in: &cell.cancellables)
      cell.textField.inputAccessoryView = toolbar
      return cell
      
    case .picture:
      guard let cell: PictureCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCollectionViewCell", for: indexPath) as? PictureCollectionViewCell
      else { return UICollectionViewCell() }
      let pictureModel: SalesApplicationSectionPictureModel? = model[indexPath.section] as? SalesApplicationSectionPictureModel
      
      cell.tag = indexPath.item
      cell.borderImageView.image = pictureModel?.images[indexPath.item]
      cell.delegate = self
      return cell
    case .comment:
      guard let cell: CommentCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentCollectionViewCell", for: indexPath) as? CommentCollectionViewCell
      else { return UICollectionViewCell() }
      let commentModel: SalesApplicationSectionCommentModel? = model[indexPath.section] as? SalesApplicationSectionCommentModel
      
      cell.updatePlaceHolder(message: commentModel?.placeHolder)
      cell.textField.text = commentModel?.content
      cell.textField.textPublisher.sink { [weak self] text in
        commentModel?.content = text ?? ""
        self?.isValid()
      }.store(in: &cell.cancellables)
           
      cell.textField.didBeginEditingPublisher
        .sink {
          UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: []) { [weak self] in
            if let keyboardHight = self?.keyboardSize.height {
              self?.collectionView.transform = CGAffineTransform(translationX: 0, y: -keyboardHight)
            }
          }
        }
        .store(in: &cell.cancellables)
      
      cell.textField.addTarget(self, action: #selector(commentEndEditing), for: .editingDidEnd)
      return cell
    }
  }
  
  @objc func commentEndEditing() {
    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: []) { [weak self] in
      self?.collectionView.transform = .identity
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
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    view.endEditing(true)
  }
}

extension SalesApplicationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if pickerView.tag == 0,
       let viewModel = viewModel {
      return viewModel.subCategories.value.count
    }
    
    return (model[pickerView.tag] as? SalesApplicationSectionPickerModel)?.items.count ?? 0
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if pickerView.tag == 0,
       let viewModel = viewModel {
      let items = viewModel.subCategories.value
      return items[row].korean
    }
    
    return (model[pickerView.tag] as? SalesApplicationSectionPickerModel)?.items[row] ?? ""
  }

}

extension SalesApplicationViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if textField.tag == 1 { return true }
    let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
    
    return (string.rangeOfCharacter(from: invalidCharacters) == nil)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    return true
  }
}

extension SalesApplicationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    guard let image: UIImage = info[.originalImage] as? UIImage else { return }
    (model[6] as? SalesApplicationSectionPictureModel)?.images[currentImageIndex] = image
    picker.dismiss(animated: true, completion: nil)
    collectionView.reloadData()
    isValid()
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
    
    navigationItem.rightBarButtonItem?.isEnabled = false
    title = "판매 신청"
    collectionView.delegate = self
    collectionView.dataSource = self
    
    collectionView.register(InputCollectionViewCell.self, forCellWithReuseIdentifier: "InputCollectionViewCell")
    collectionView.register(PickerCollectionViewCell.self, forCellWithReuseIdentifier: "PickerCollectionViewCell")
    collectionView.register(PictureCollectionViewCell.self, forCellWithReuseIdentifier: "PictureCollectionViewCell")
    collectionView.register(CommentCollectionViewCell.self, forCellWithReuseIdentifier: "CommentCollectionViewCell")
    
    collectionView.register(SalesApplicationSectionHeader.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: SalesApplicationSectionHeader.identifier)
  }
  
  func requestSalesApplication() {
    guard let viewModel = viewModel else { return }
    let networkProvider: NetworkProvider = .init()
//    let categoryIdx = (model[0] as? SalesApplicationSectionPickerModel)?.items.firstIndex(of: model[0].content) ?? -1
    let categoryIdx = viewModel.subCategories.value.firstIndex { $0.korean == model[0].content } ?? -1
    let clothingStatus =  (model[5] as? SalesApplicationSectionPickerModel)?.items.firstIndex(of: model[5].content) ?? -1
    
    let images = (model[6] as? SalesApplicationSectionPictureModel)?.images.values.compactMap({
      $0
    })
    
    let information = SalesApplicationInformation(categoryIdx: viewModel.subCategories.value[categoryIdx].idx, brandName: model[1].content, purchasePrice: Int(model[2].content) ?? 0, desiredPrice: Int(model[3].content) ?? 0, clothingSize: model[4].content, clothingStatus: clothingStatus, comments: model[7].content, images: images ?? [])
    //
    let endPoint = SalesApplicationEndPoint.requestSalesApplication(inforamtion: information)
    
    let salesPublisher: AnyPublisher<Result<BaseResponse<NillResponse>, NetworkError>, Never> = networkProvider.request(route: endPoint, images: information.images)
    
    salesPublisher
      .sink { [weak self] result in
        switch result {
        case .success(let responseResult):
          
          guard
            responseResult.status != "UNAUTHORIZED"
          else
          {
            
            Authorization.shared.requestWithNewAccessToken { [weak self] in
              self?.requestSalesApplication()
            }
            return
          }
          DispatchQueue.main.async {
            SceneCoordinator.shared.transition(scene: SalesApplicationCompleteScene(), using: .push, animated: true)
          }

        
        case .failure(let error):
          DispatchQueue.main.async {
          self?.showAlert(message: error.localizedDescription)
          }
        }
      }
      .store(in: &cancellables)
  }
  
  @objc func sendInformationToServer(sender: UITapGestureRecognizer) {
    
    requestSalesApplication()
   
   
  }
  
  @objc func cancel(sender: UITapGestureRecognizer) {
    SceneCoordinator.shared.close(animated: true)
  }
  
  func isValid() {
    if model.allSatisfy({ item in
      switch item.isNecessary {
      case false:
        return true
      case true:
        if item.content.isEmpty {
          if let imageItem = item as? SalesApplicationSectionPictureModel {
            if !imageItem.images.isEmpty {
              return true
            }
          }
            return false
        }
        return true
      }
    }) {
      navigationItem.rightBarButtonItem?.isEnabled = true
    } else{
      navigationItem.rightBarButtonItem?.isEnabled = false
    }
  }
}

extension UIViewController {
  
  func showAlert(message: String) {
      let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
      let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
      alertController.addAction(cancelAction)
      present(alertController, animated: true, completion: nil)
  }
  
}
