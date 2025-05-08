import SwiftUI

// 메모이제이션 (React의 useMemo와 유사)
// React: const memoizedValue = useMemo(() => computeExpensiveValue(a, b), [a, b]);
struct MemoizationExample: View {
    @State private var count = 0
    @State private var text = ""
    
    // 계산 비용이 큰 작업을 메모이제이션
    private var expensiveComputation: String {
        // 실제 앱에서는 더 복잡한 계산이 있을 수 있음
        let result = (0...count).reduce(0, +)
        return "Sum: \(result)"
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text(expensiveComputation)
                .font(.title)
            
            Button("Increment") {
                count += 1
            }
            
            TextField("Enter text", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        }
        .padding()
        .navigationTitle("Memoization")
    }
}

// 지연 로딩 (React의 React.lazy와 유사)
// React: const LazyComponent = React.lazy(() => import('./LazyComponent'));
struct LazyLoadingExample: View {
    @State private var showHeavyView = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Load Heavy View") {
                showHeavyView = true
            }
            
            if showHeavyView {
                HeavyView()
                    .transition(.opacity)
            }
        }
        .padding()
        .navigationTitle("Lazy Loading")
    }
}

struct HeavyView: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<1000) { index in
                    Text("Item \(index)")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(index % 2 == 0 ? Color.gray.opacity(0.2) : Color.clear)
                }
            }
        }
    }
}

// 뷰 모디파이어 최적화 (React의 스타일 최적화와 유사)
// React: const styles = useMemo(() => ({ color: isActive ? 'blue' : 'gray' }), [isActive]);
struct ViewModifierOptimization: View {
    @State private var isActive = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Optimized View")
                .modifier(OptimizedModifier(isActive: isActive))
            
            Button("Toggle State") {
                isActive.toggle()
            }
        }
        .padding()
        .navigationTitle("View Modifier")
    }
}

struct OptimizedModifier: ViewModifier {
    let isActive: Bool
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(isActive ? .blue : .gray)
            .padding()
            .background(isActive ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
            .cornerRadius(8)
    }
}

// 이미지 최적화 (React의 이미지 최적화와 유사)
// React: <img src={imageUrl} loading="lazy" />
struct ImageOptimization: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<10) { index in
                    AsyncImage(url: URL(string: "https://picsum.photos/200/300?random=\(index)")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        case .failure:
                            Image(systemName: "photo")
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(height: 200)
                    .cornerRadius(8)
                }
            }
            .padding()
        }
        .navigationTitle("Image Optimization")
    }
}

// 상태 관리 최적화 (React의 useCallback과 유사)
// React: const handleClick = useCallback(() => { setCount(c => c + 1); }, []);
struct StateOptimization: View {
    @State private var count = 0
    @State private var text = ""
    
    // 상태 업데이트 함수를 최적화
    private func incrementCount() {
        count += 1
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Count: \(count)")
                .font(.title)
            
            Button("Increment") {
                incrementCount()
            }
            
            TextField("Enter text", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        }
        .padding()
        .navigationTitle("State Optimization")
    }
}

// 프리뷰
struct Performance_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Group {
                MemoizationExample()
                LazyLoadingExample()
                ViewModifierOptimization()
                ImageOptimization()
                StateOptimization()
            }
        }
    }
} 