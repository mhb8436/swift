import SwiftUI

// 기본 접근성 (React의 aria 속성과 유사)
// React: <button aria-label="Close" onClick={handleClose}>
struct BasicAccessibility: View {
    @State private var isExpanded = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                isExpanded.toggle()
            }) {
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .font(.title)
            }
            .accessibilityLabel(isExpanded ? "Collapse" : "Expand")
            .accessibilityHint("Double tap to \(isExpanded ? "collapse" : "expand") the content")
            
            if isExpanded {
                Text("This is expanded content")
                    .accessibilityAddTraits(.isHeader)
            }
        }
        .padding()
        .navigationTitle("Basic Accessibility")
    }
}

// 동적 접근성 (React의 동적 aria 속성과 유사)
// React: <div role="alert" aria-live="polite">{message}</div>
struct DynamicAccessibility: View {
    @State private var message = ""
    @State private var showMessage = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Show Message") {
                message = "This is an important message!"
                showMessage = true
            }
            .accessibilityLabel("Show important message")
            
            if showMessage {
                Text(message)
                    .padding()
                    .background(Color.yellow.opacity(0.3))
                    .cornerRadius(8)
                    .accessibilityAddTraits(.isHeader)
                    .accessibilityLabel("Important message: \(message)")
            }
        }
        .padding()
        .navigationTitle("Dynamic Accessibility")
    }
}

// 접근성 그룹 (React의 role="group"과 유사)
// React: <div role="group" aria-labelledby="group-label">
struct AccessibilityGroup: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Form Controls")
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            
            VStack(alignment: .leading, spacing: 10) {
                Toggle("Option 1", isOn: .constant(true))
                Toggle("Option 2", isOn: .constant(false))
                Toggle("Option 3", isOn: .constant(true))
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Form options")
            .accessibilityValue("Option 1 is on, Option 2 is off, Option 3 is on")
        }
        .padding()
        .navigationTitle("Accessibility Group")
    }
}

// 접근성 동작 (React의 키보드 접근성과 유사)
// React: <button onKeyDown={handleKeyDown}>
struct AccessibilityActions: View {
    @State private var count = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Count: \(count)")
                .font(.title)
                .accessibilityLabel("Current count is \(count)")
            
            HStack(spacing: 20) {
                Button("Decrement") {
                    count -= 1
                }
                .accessibilityLabel("Decrement count")
                .accessibilityHint("Double tap to decrease the count by one")
                
                Button("Increment") {
                    count += 1
                }
                .accessibilityLabel("Increment count")
                .accessibilityHint("Double tap to increase the count by one")
            }
        }
        .padding()
        .navigationTitle("Accessibility Actions")
    }
}

// 접근성 이미지 (React의 alt 텍스트와 유사)
// React: <img src={imageUrl} alt="Description of image" />
struct AccessibilityImages: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "star.fill")
                .font(.system(size: 50))
                .foregroundColor(.yellow)
                .accessibilityLabel("Favorite")
                .accessibilityHint("Double tap to toggle favorite status")
            
            Image(systemName: "heart.fill")
                .font(.system(size: 50))
                .foregroundColor(.red)
                .accessibilityLabel("Like")
                .accessibilityHint("Double tap to like this item")
            
            Image(systemName: "bell.fill")
                .font(.system(size: 50))
                .foregroundColor(.blue)
                .accessibilityLabel("Notifications")
                .accessibilityHint("Double tap to view notifications")
        }
        .padding()
        .navigationTitle("Accessibility Images")
    }
}

// 접근성 네비게이션 (React의 키보드 네비게이션과 유사)
// React: <nav role="navigation" aria-label="Main navigation">
struct AccessibilityNavigation: View {
    var body: some View {
        List {
            Section(header: Text("Navigation")) {
                NavigationLink("Home") {
                    Text("Home View")
                }
                .accessibilityLabel("Navigate to home")
                
                NavigationLink("Profile") {
                    Text("Profile View")
                }
                .accessibilityLabel("Navigate to profile")
                
                NavigationLink("Settings") {
                    Text("Settings View")
                }
                .accessibilityLabel("Navigate to settings")
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Main navigation menu")
        }
        .navigationTitle("Accessibility Navigation")
    }
}

// 프리뷰
struct Accessibility_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Group {
                BasicAccessibility()
                DynamicAccessibility()
                AccessibilityGroup()
                AccessibilityActions()
                AccessibilityImages()
                AccessibilityNavigation()
            }
        }
    }
} 