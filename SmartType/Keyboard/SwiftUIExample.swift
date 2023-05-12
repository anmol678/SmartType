//
//  SwiftUIExample.swift
//  SmartType
//
//  Created by Anmol Jain on 5/11/23.
//

import SwiftUI

//struct ExampleVCWrapper: UIViewControllerRepresentable {
//    // Implement the required methods
//
//    func makeUIViewController(context: Context) -> ExampleVC {
//        return ExampleVC() // Create and return your UIKit view controller
//    }
//
//    func updateUIViewController(_ uiViewController: ExampleVC, context: Context) {
//        // Perform any updates to the view controller, if necessary
//    }
//
//    // Add any other customizations or configurations as needed
//}

//class SharedTextView: ObservableObject {
//    @Published var textView: UITextView? = nil
//}
//
//struct TextViewRepresentable: UIViewRepresentable {
//    @EnvironmentObject var sharedTextView: SharedTextView
//    @Binding var text: String
//
//    func makeUIView(context: Context) -> UITextView {
//        let textView = UITextView()
//        textView.text = text
//        sharedTextView.textView = textView
//        return textView
//    }
//
//    func updateUIView(_ textView: UITextView, context: Context) {
//        textView.text = text
//    }
//}

//struct CYRKeyboardButtonRepresentable: UIViewRepresentable {
//    var input: String
//    var inputOptions: [String]
//    @EnvironmentObject var sharedTextView: SharedTextView
//    var textInput: UITextInput
//
//    func makeUIView(context: Context) -> CYRKeyboardButton {
//        let button = CYRKeyboardButton()
//        button.input = input
//        button.inputOptions = inputOptions
//        button.textInput = textInput
//        return button
//    }
//
//    func updateUIView(_ button: CYRKeyboardButton, context: Context) {
//        // Update the button's state if necessary.
//    }
//}

//struct ExampleView: View {
//    @State private var text: String = ""
//    let keys = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
//    @EnvironmentObject var sharedTextView: SharedTextView
//
//    var textinput: UITextInput
//
//    var body: some View {
//        VStack {
//            TextViewRepresentable(text: $text)
//            Divider()
//            HStack {
//                ForEach(keys, id: \.self) { key in
//                    CYRKeyboardButtonRepresentable(input: key, inputOptions: ["A", "B", "C", "D"], textInput: textinput)
//                        .frame(maxWidth: .infinity, maxHeight: 40)
//                }
//            }
//            .frame(maxWidth: .infinity)
//            .padding(16)
//        }
//    }
//}

//struct ExampleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExampleView()
//            .environmentObject(SharedTextView())
//            .preferredColorScheme(.dark)
//    }
//}



