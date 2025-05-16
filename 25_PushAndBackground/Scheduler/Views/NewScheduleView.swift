import SwiftUI

struct NewScheduleView: View {
    let onSave: (String, String, Date, Bool) -> Void
    
    @State private var title = ""
    @State private var description = ""
    @State private var dateTime = Date()
    @State private var enableNotification = true
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("제목", text: $title)
                    TextField("설명", text: $description)
                }
                
                Section {
                    DatePicker("날짜 및 시간", selection: $dateTime)
                }
                
                Section {
                    Toggle("알림 설정", isOn: $enableNotification)
                }
            }
            .navigationTitle("새 일정")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("저장") {
                        onSave(title, description, dateTime, enableNotification)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}
