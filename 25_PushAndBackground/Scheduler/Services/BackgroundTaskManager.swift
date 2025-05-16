import BackgroundTasks
import UIKit

class BackgroundTaskManager {
    static let shared = BackgroundTaskManager()
    
    private init() {
        registerBackgroundTasks()
    }
    
    func registerBackgroundTasks() {
        BGTaskScheduler.shared.register(
            forTaskWithIdentifier: "com.example.scheduler.refresh",
            using: nil
        ) { task in
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
        
        BGTaskScheduler.shared.register(
            forTaskWithIdentifier: "com.example.scheduler.processing",
            using: nil
        ) { task in
            self.handleBackgroundProcessing(task: task as! BGProcessingTask)
        }
    }
    
    func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: "com.example.scheduler.refresh")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 15 * 60) // 15분 후
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }
    
    func scheduleBackgroundProcessing() {
        let request = BGProcessingTaskRequest(identifier: "com.example.scheduler.processing")
        request.requiresNetworkConnectivity = true
        request.requiresExternalPower = false
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule background processing: \(error)")
        }
    }
    
    private func handleAppRefresh(task: BGAppRefreshTask) {
        // 작업 완료 전에 새로운 백그라운드 작업 예약
        scheduleAppRefresh()
        
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        
        // 일정 체크 및 알림 업데이트 작업
        let operation = BlockOperation {
            // 여기서 일정을 체크하고 필요한 작업 수행
            // 실제 앱에서는 데이터베이스 조회 등의 작업 수행
        }
        
        operation.completionBlock = {
            task.setTaskCompleted(success: true)
        }
        
        // 시간 초과 처리
        task.expirationHandler = {
            queue.cancelAllOperations()
        }
        
        queue.addOperation(operation)
    }
    
    private func handleBackgroundProcessing(task: BGProcessingTask) {
        scheduleBackgroundProcessing()
        
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        
        // 무거운 작업 수행 (데이터 정리, 캐시 정리 등)
        let operation = BlockOperation {
            // 실제 앱에서는 여기서 무거운 작업 수행
        }
        
        operation.completionBlock = {
            task.setTaskCompleted(success: true)
        }
        
        task.expirationHandler = {
            queue.cancelAllOperations()
        }
        
        queue.addOperation(operation)
    }
}
