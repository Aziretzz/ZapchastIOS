//
//  AddProductView.swift
//  Zapchast
//
//  Created by Урмат Асаналиев on 13/9/24.
//

import SwiftUI

struct AddProductView: View {
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var goCategory = false

    var body: some View {
        NavigationView {
            VStack {
                
                // Верхняя панель
                ZStack {
                    Color(hex: "#232A40")
                        .ignoresSafeArea(edges: .top)
                        .frame(height: 80)
                    
                    Text("Добавление товара")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Upload Image/Video Button
                        Button(action: {
                            showImagePicker = true
                        }) {
                            ZStack {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.1))
                                    .frame(height: 300)
                                    .cornerRadius(15)
                                
                                if let image = selectedImage {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 300)
                                        .cornerRadius(15)
                                } else {
                                    HStack {
                                        Image(systemName: "camera")
                                            .font(.system(size: 20))
                                            .foregroundColor(.black.opacity(0.7))
                                        
                                        Text("Upload images/Video")
                                            .foregroundColor(.black)
                                            .font(.headline)
                                    }
                                }
                            }
                        }
                        .buttonStyle(PlainButtonStyle()) // No button style, so it looks more like a tap-able area
                        .sheet(isPresented: $showImagePicker) {
                            ImagePicker(image: $selectedImage)
                        }
                        .padding()
                        
                        // Title Text Field
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Title")
                                .font(.headline)
                                .foregroundColor(.black)
                            
                            TextField("Enter title", text: $title)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                                .font(.body)
                        }
                        .padding(.horizontal)
                        
                        // Description Text Field
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Description")
                                .font(.headline)
                                .foregroundColor(.black)
                            
                            TextEditor(text: $description)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(10)
                                .frame(height: 150)
                                .font(.body)
                        }
                        .padding(.horizontal)
                        
                        Button(action: {
                            // Handle login action
                            goCategory = true
                        }) {
                            Text("Выбрать категории")
                                .font(.system(size: 18, weight: .bold))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(hex: "#21263E"))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding(.horizontal, 16)
                        
                        NavigationLink(destination: CategoriesView(), isActive: $goCategory) {
                            EmptyView()
                        }
                        
                        Spacer()
                    }
                    .padding(.top)
                }
                .edgesIgnoringSafeArea(.bottom) // Makes sure scroll is usable for large content
            }
        }
    }
}

// ImagePicker to handle image selection
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }

            picker.dismiss(animated: true)
        }
    }
}

#Preview {
    AddProductView()
}
