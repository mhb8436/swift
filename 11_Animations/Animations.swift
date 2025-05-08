import SwiftUI

// 기본 애니메이션 (React의 CSS transition과 유사)
// React: transition: all 0.3s ease-in-out;
struct BasicAnimation: View {
    @State private var isExpanded = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Toggle Size") {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isExpanded.toggle()
                }
            }
            .buttonStyle(.bordered)
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue)
                .frame(width: isExpanded ? 200 : 100, height: isExpanded ? 200 : 100)
                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isExpanded)
        }
        .padding()
    }
}

// 시퀀스 애니메이션 (React의 CSS keyframes와 유사)
// React: @keyframes bounce { 0%, 100% { transform: translateY(0); } 50% { transform: translateY(-20px); } }
struct SequenceAnimation: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Start Animation") {
                isAnimating.toggle()
            }
            .buttonStyle(.bordered)
            
            Circle()
                .fill(Color.green)
                .frame(width: 50, height: 50)
                .offset(y: isAnimating ? -50 : 0)
                .animation(
                    Animation.easeInOut(duration: 0.5)
                        .repeatForever(autoreverses: true),
                    value: isAnimating
                )
        }
        .padding()
    }
}

// 전환 효과 (React의 React Transition Group과 유사)
// React: <CSSTransition in={show} timeout={300} classNames="fade">
struct TransitionExample: View {
    @State private var showView = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Toggle View") {
                withAnimation {
                    showView.toggle()
                }
            }
            .buttonStyle(.bordered)
            
            if showView {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.purple)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(
                        insertion: .scale.combined(with: .opacity),
                        removal: .opacity
                    ))
            }
        }
        .padding()
    }
}

// 제스처 기반 애니메이션 (React의 react-spring과 유사)
// React: const [{ x }, api] = useSpring(() => ({ x: 0 }))
struct GestureAnimation: View {
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    
    var body: some View {
        VStack {
            Text("Drag the circle")
                .font(.headline)
            
            Circle()
                .fill(isDragging ? Color.red : Color.blue)
                .frame(width: 100, height: 100)
                .offset(offset)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            offset = gesture.translation
                            isDragging = true
                        }
                        .onEnded { _ in
                            withAnimation(.spring()) {
                                offset = .zero
                                isDragging = false
                            }
                        }
                )
        }
        .padding()
    }
}

// 커스텀 애니메이션 (React의 CSS custom properties와 유사)
// React: --custom-property: value;
struct CustomAnimation: View {
    @State private var progress: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Animate Progress") {
                withAnimation(.easeInOut(duration: 2)) {
                    progress = 1
                }
            }
            .buttonStyle(.bordered)
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 20)
                        .cornerRadius(10)
                    
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: geometry.size.width * progress, height: 20)
                        .cornerRadius(10)
                }
            }
            .frame(height: 20)
            .padding()
        }
    }
}

// 애니메이션 모디파이어 (React의 CSS transform과 유사)
// React: transform: rotate(45deg) scale(1.2);
struct ModifierAnimation: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Animate") {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                    isAnimating.toggle()
                }
            }
            .buttonStyle(.bordered)
            
            Text("Hello, SwiftUI!")
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .scaleEffect(isAnimating ? 1.2 : 1.0)
                .opacity(isAnimating ? 1.0 : 0.5)
        }
        .padding()
    }
}

// 프리뷰
struct Animations_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BasicAnimation()
            SequenceAnimation()
            TransitionExample()
            GestureAnimation()
            CustomAnimation()
            ModifierAnimation()
        }
    }
} 