import SwiftUI

// 기본 리스트 (React의 map과 유사)
// React: items.map(item => <div key={item.id}>{item.name}</div>)
struct BasicList: View {
    let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    
    var body: some View {
        List(items, id: \.self) { item in
            Text(item)
        }
        .navigationTitle("Basic List")
    }
}

// 커스텀 아이템 리스트 (React의 컴포넌트 렌더링과 유사)
// React: items.map(item => <ListItem key={item.id} item={item} />)
struct CustomList: View {
    struct ListItem: Identifiable {
        let id = UUID()
        let title: String
        let subtitle: String
        let color: Color
    }
    
    let items = [
        ListItem(title: "First Item", subtitle: "Description 1", color: .blue),
        ListItem(title: "Second Item", subtitle: "Description 2", color: .green),
        ListItem(title: "Third Item", subtitle: "Description 3", color: .orange),
        ListItem(title: "Fourth Item", subtitle: "Description 4", color: .purple)
    ]
    
    var body: some View {
        List(items) { item in
            HStack {
                Circle()
                    .fill(item.color)
                    .frame(width: 30, height: 30)
                
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.headline)
                    Text(item.subtitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical, 8)
        }
        .navigationTitle("Custom List")
    }
}

// 섹션이 있는 리스트 (React의 그룹화된 렌더링과 유사)
// React: Object.entries(groupedItems).map(([section, items]) => <Section key={section} title={section} items={items} />)
struct SectionedList: View {
    struct Item: Identifiable {
        let id = UUID()
        let name: String
        let category: String
    }
    
    let items = [
        Item(name: "Apple", category: "Fruits"),
        Item(name: "Banana", category: "Fruits"),
        Item(name: "Carrot", category: "Vegetables"),
        Item(name: "Potato", category: "Vegetables"),
        Item(name: "Chicken", category: "Meat"),
        Item(name: "Beef", category: "Meat")
    ]
    
    var groupedItems: [String: [Item]] {
        Dictionary(grouping: items) { $0.category }
    }
    
    var body: some View {
        List {
            ForEach(Array(groupedItems.keys.sorted()), id: \.self) { category in
                Section(header: Text(category)) {
                    ForEach(groupedItems[category] ?? []) { item in
                        Text(item.name)
                    }
                }
            }
        }
        .navigationTitle("Sectioned List")
    }
}

// 기본 그리드 (React의 CSS Grid와 유사)
// React: <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)' }}>
struct BasicGrid: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(1...12, id: \.self) { number in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                        .frame(height: 100)
                        .overlay(
                            Text("Item \(number)")
                                .foregroundColor(.white)
                        )
                }
            }
            .padding()
        }
        .navigationTitle("Basic Grid")
    }
}

// 커스텀 그리드 (React의 그리드 컴포넌트와 유사)
// React: <Grid container spacing={2}> {items.map(item => <Grid item xs={4}><Card item={item} /></Grid>)}
struct CustomGrid: View {
    struct CustomGridItem: Identifiable {
        let id = UUID()
        let title: String
        let color: Color
        let size: CustomGridItem.Size
    }
    
    let items = [
        CustomGridItem(title: "Large", color: .blue, size: .large),
        CustomGridItem(title: "Medium", color: .green, size: .medium),
        CustomGridItem(title: "Small", color: .orange, size: .small),
        CustomGridItem(title: "Large", color: .purple, size: .large),
        CustomGridItem(title: "Medium", color: .red, size: .medium),
        CustomGridItem(title: "Small", color: .yellow, size: .small)
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(items) { item in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(item.color)
                        .frame(height: item.size == .large ? 200 : item.size == .medium ? 150 : 100)
                        .overlay(
                            Text(item.title)
                                .foregroundColor(.white)
                                .font(.headline)
                        )
                }
            }
            .padding()
        }
        .navigationTitle("Custom Grid")
    }
}

// 그리드 아이템 크기 열거형
extension CustomGrid.CustomGridItem {
    enum Size {
        case small
        case medium
        case large
    }
}

// 프리뷰
struct ListsAndGrids_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Group {
                BasicList()
                CustomList()
                SectionedList()
                BasicGrid()
                CustomGrid()
            }
        }
    }
} 