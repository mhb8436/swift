import SwiftUI

// SwiftUI의 기본 레이아웃 시스템 (React의 Flexbox와 유사)
// React: <div style={{ display: 'flex', flexDirection: 'column' }}>

// VStack (React의 flex-direction: column과 유사)
struct VStackExample: View {
    var body: some View {
        VStack(spacing: 20) { // spacing은 React의 gap과 유사
            Text("First Item")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            
            Text("Second Item")
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            
            Text("Third Item")
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding()
    }
}

// HStack (React의 flex-direction: row와 유사)
struct HStackExample: View {
    var body: some View {
        HStack(spacing: 10) {
            ForEach(1...3, id: \.self) { number in
                Text("Item \(number)")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

// ZStack (React의 position: absolute와 유사)
struct ZStackExample: View {
    var body: some View {
        ZStack {
            // 배경
            Color.blue
                .frame(width: 200, height: 200)
                .cornerRadius(20)
            
            // 중간 레이어
            Color.white
                .frame(width: 150, height: 150)
                .cornerRadius(15)
            
            // 최상위 레이어
            Text("ZStack")
                .font(.title)
                .foregroundColor(.blue)
        }
    }
}

// LazyVGrid (React의 CSS Grid와 유사)
struct LazyVGridExample: View {
    // 그리드 레이아웃 정의
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(1...10, id: \.self) { number in
                    Text("Item \(number)")
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

// GeometryReader (React의 useRef와 유사)
struct GeometryReaderExample: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Width: \(Int(geometry.size.width))")
                Text("Height: \(Int(geometry.size.height))")
                
                // 화면의 절반 크기로 사각형 그리기
                Rectangle()
                    .fill(Color.blue)
                    .frame(
                        width: geometry.size.width * 0.5,
                        height: geometry.size.height * 0.5
                    )
            }
        }
    }
}

// 커스텀 레이아웃 (React의 styled-components와 유사)
struct CustomLayout: View {
    var body: some View {
        VStack(spacing: 20) {
            // 헤더
            Text("Header")
                .font(.title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
            
            // 메인 컨텐츠
            HStack(spacing: 20) {
                // 사이드바
                VStack {
                    Text("Sidebar")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                }
                .frame(width: 100)
                
                // 메인 컨텐츠 영역
                VStack(alignment: .leading, spacing: 10) {
                    Text("Main Content")
                        .font(.headline)
                    Text("This is the main content area")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.lightGray)
            }
            .frame(maxHeight: .infinity)
            
            // 푸터
            Text("Footer")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
        }
    }
}

// 반응형 레이아웃 (React의 media queries와 유사)
struct ResponsiveLayout: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        if horizontalSizeClass == .compact {
            // 모바일 레이아웃
            VStack {
                Text("Mobile Layout")
                    .font(.title)
                Text("This is optimized for mobile devices")
            }
            .padding()
        } else {
            // 데스크톱 레이아웃
            HStack {
                Text("Desktop Layout")
                    .font(.title)
                Text("This is optimized for desktop devices")
            }
            .padding()
        }
    }
}

// 프리뷰
struct Layouts_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStackExample()
            HStackExample()
            ZStackExample()
            LazyVGridExample()
            GeometryReaderExample()
            CustomLayout()
            ResponsiveLayout()
        }
    }
} 