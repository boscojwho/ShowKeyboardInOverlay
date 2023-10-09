import SwiftUI

@available(iOS 17.0, *)
struct ContentView: View {
    
    @FocusState private var isSearching: Bool
    @State private var text: String = ""
    
    var body: some View {
//        example1
//        example2
        example3
    }
    
    /// EXAMPLE 1
    /// This works, but the etnire inset view moves with keyboard.
    private var example1: some View {
        GeometryReader { geometry in
            NavigationStack {
                List {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Hello, world!")
                    ForEach(0..<30) { value in
                        Text("\(value)")
                    }
                }
                .safeAreaInset(edge: .bottom) {
                    Spacer()
                        .frame(height: 120)
                }
            }
            .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
                VStack {
                    Spacer()
                        .frame(width: geometry.size.width, height: 120)
                        .background(
                            Color.teal
                                .background(.ultraThinMaterial)
                                .ignoresSafeArea(.keyboard, edges: .bottom)
                        )
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
                .overlay(alignment: .top) {
                    ScrollView(.horizontal) {
                        MyTextField(text: $text)
                            .frame(width: geometry.size.width)
                            .background(.purple)
                    }
                    .scrollClipDisabled()
                    .background(.pink)
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                }
            }
        }
    }
    
    /// EXAMPLE 2
    /// This works?
    private var example2: some View {
        GeometryReader { geometry in
            NavigationStack {
                List {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Hello, world!")
                    ForEach(0..<30) { value in
                        Text("\(value)")
                    }
                }
                /// Manually add padding for bottom safe area, where padding value is equal to safe area inset.
                .safeAreaPadding(.bottom, 120)
                /// Ignore safe area for bottom container to workaround issue where a white background view apeears on screen when dismissing keyboard.
                .ignoresSafeArea(.all, edges: .bottom)
                /// Add safe inset area, otherwise white background view appears when keyboard is animating dismissal.
                .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
                    Spacer(minLength: 0)
                        .frame(height: 120)
                }
            }
            /// Overlay is where custom content (e.g. custom toolbar) gets added to view hierarchy.
            .overlay(alignment: .bottom) {
                ScrollView(.horizontal) {
                    MyTextField(text: $text)
                        .frame(width: geometry.size.width)
                }
                .scrollClipDisabled()
                .background(
                    Color.clear
                        .background(.ultraThinMaterial)
                        .ignoresSafeArea(.keyboard, edges: [.leading, .trailing, .bottom])
                )
            }
        }
    }
    
    /// EXAMPLE 3
    /// - Search field and toolbar items.
    /// - Toolbar shows/hides with animation when keyboard animates.
    private var example3: some View {
        GeometryReader { geometry in
            NavigationStack {
                List {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Hello, world!")
                    ForEach(0..<30) { value in
                        Text("\(value)")
                    }
                }
                /// Manually add padding for bottom safe area, where padding value is equal to safe area inset.
                .safeAreaPadding(.bottom, 120)
                /// Ignore safe area for bottom container to workaround issue where a white background view apeears on screen when dismissing keyboard.
                .ignoresSafeArea(.all, edges: .bottom)
                /// Add safe inset area, otherwise white background view appears when keyboard is animating dismissal.
                .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
                    Spacer(minLength: 0)
                        .frame(height: 120)
                }
            }
            /// Overlay is where custom content (e.g. custom toolbar) gets added to view hierarchy.
            .overlay(alignment: .bottom) {
                VStack {
                    ScrollView(.horizontal) {
                        MyTextField(text: $text)
                            .frame(width: geometry.size.width)
                            .focused($isSearching)
                    }
                    .scrollClipDisabled()
                    HStack {
                        if !isSearching {
                            Spacer()
                            Button("", systemImage: "square.and.arrow.up") {}
                            Spacer()
                            Button("", systemImage: "square.and.arrow.up") {}
                            Spacer()
                            Button("", systemImage: "square.and.arrow.up") {}
                            Spacer()
                            Button("", systemImage: "square.and.arrow.up") {}
                            Spacer()
                            Button("", systemImage: "square.and.arrow.up") {}
                            Spacer()
                        }
                    }
                }
                .background(
                    Color.clear
                        .background(.ultraThinMaterial)
                        .ignoresSafeArea(.keyboard, edges: [.leading, .trailing, .bottom])
                )
                .animation(.default, value: isSearching)
            }
        }
    }
}

struct MyTextField: View {
    @Binding var text: String
    var body: some View {
        HStack {
            Spacer(minLength: 30)
            TextField("Overlay Text Field", text: $text)
                .frame(minWidth: 240)
                .font(.title2)
                .textFieldStyle(MyTextFieldStyle(isActive: .constant(false)))
            Spacer(minLength: 30)
        }
    }
}

struct MyTextFieldStyle: TextFieldStyle {
    
    @Binding var isActive: Bool
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(EdgeInsets(top: 10, leading: 12, bottom: 10, trailing: 12))
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(.bar)
                    .shadow(radius: isActive ? 0 : 6)
            )
            .padding()
    }
}
