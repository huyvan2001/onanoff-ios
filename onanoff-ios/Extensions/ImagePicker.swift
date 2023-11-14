//
//  ImagePicker.swift
//  DescendantsDNA
//
//  Created by  on 01/09/2023.
//

import Combine
import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
	@Environment(\.presentationMode) var presentationMode
	@Binding var photoPickerResult: PHPickerResult?
	
	func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> some UIViewController {
		var config = PHPickerConfiguration()
		config.filter = .images
		config.selectionLimit = 1
		config.preferredAssetRepresentationMode = .current
		
		let picker = PHPickerViewController(configuration: config)
		picker.delegate = context.coordinator
		return picker
	}
	
	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
		
	}
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	class Coordinator: PHPickerViewControllerDelegate {
		let parent: ImagePicker
		
		init(_ parent: ImagePicker) {
			self.parent = parent
		}
		
		func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
			self.parent.presentationMode.wrappedValue.dismiss()
			self.parent.photoPickerResult = results.first
		}
	}
}

extension PHPickerResult {
	
	func loadImage() -> Future<UIImage?, Never> {
		return Future { promise in
			guard case let _provider = self.itemProvider,
				  _provider.canLoadObject(ofClass: UIImage.self)
			else { return promise(.success(nil)) }
			
			_provider.loadDataRepresentation(forTypeIdentifier: UTType.image.identifier) { data, err in
				if let _data = data, let _img = UIImage.init(data: _data) {
					DispatchQueue.main.async {
						return promise(.success(_img))
					}
				} else {
					return promise(.success(nil))
				}
			}
		}
	}
}
