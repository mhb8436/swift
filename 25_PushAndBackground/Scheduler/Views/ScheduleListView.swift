import SwiftUI

struct ScheduleListView: View {
    @StateObject private var viewModel = ScheduleViewModel()
    @State private var showingNewSchedule = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.schedules) { schedule in
                    ScheduleRow(schedule: schedule) {
                        viewModel.toggleComplete(schedule)
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            viewModel.deleteSchedule(schedule)
                        } label: {
                            Label("삭제", systemImage: "trash")
                        }
                    }
                }
            }
            .navigationTitle("일정")
            .toolbar {
                Button {
                    showingNewSchedule = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingNewSchedule) {
                NewScheduleView { title, description, date, enableNotification in
                    Task {
                        await viewModel.addSchedule(
                            title: title,
                            description: description,
                            dateTime: date,
                            enableNotification: enableNotification
                        )
                    }
                }
            }
            .alert("오류", isPresented: .constant(viewModel.error != nil)) {
                Button("확인") {
                    viewModel.error = nil
                }
            } message: {
                Text(viewModel.error?.localizedDescription ?? "알 수 없는 오류가 발생했습니다.")
            }
        }
    }
}

struct ScheduleRow: View {
    let schedule: Schedule
    let onToggle: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(schedule.title)
                    .font(.headline)
                    .strikethrough(schedule.isCompleted)
                
                Text(schedule.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(schedule.dateTime.formatted())
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: onToggle) {
                Image(systemName: schedule.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(schedule.isCompleted ? .green : .gray)
            }
        }
        .padding(.vertical, 4)
    }
}
