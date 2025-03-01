# 📌 Interactive Task Manager (SwiftUI 5)

## 📖 Overview
This is an advanced **task management** iOS application built using **SwiftUI 5**, **Core Data**, and **iOS 18**.  
It follows **Apple's Human Interface Guidelines (HIG)**, focusing on **smooth animations, intuitive navigation, accessibility, and a modern UI**.

---

## 🚀 Features

### 📝 **Task Management**
- ✅ **Create and Delete Tasks**: Manage tasks efficiently.
- 🔥 **Prioritization**: Set tasks as **Low, Medium, High**.
- 📅 **Due Date Selection**: Pick deadlines with a **Date Picker**.
- ✅ **Task Completion**: Mark tasks as **done**.

### 🔎 **Sorting & Filtering**
- **Sorting Options**:
  - 📌 **By Priority** (High → Low)
  - 🕒 **By Due Date** (Soonest → Latest)
  - 🔠 **Alphabetically** (A → Z)
- **Filter by Status**:
  - 📍 **All**
  - ⏳ **Pending**
  - ✔️ **Completed**

### 🎨 **Theming**
- 🌗 **Light & Dark Mode**: Supports automatic theme switching.
- 🎨 **Custom Accent Colors**: Users can **personalize UI colors**.

### 🎬 **Smooth Animations**
- 🏗 **Task Addition/Removal**: Uses a **fade & scale** effect.
- ✅ **Task Completion Swipe**: **Haptic feedback** on completion.
- 🔵 **Pulse Effect**: Highlights the "Add Task" button.

### 🤝 **Gestures & Interactions**
- ➡️ **Swipe to Delete**: Remove tasks with a left swipe.
- ✅ **Swipe to Complete**: Mark tasks as **done** with a right swipe.
- 🛑 **Undo Deletion**: Showing alert for **undoing deletions**.
- 📦 **Drag & Drop**: **Reorder tasks** with haptic feedback.

### 📊 **Custom Progress Indicator**
- 🔵 **Circular Progress Ring**: Shows **task completion percentage** dynamically.

### 🏆 **Engaging Empty State**
- 📌 **Illustrated Empty View**: Uses **SF Symbols** and motivational text.

### 🦾 **Accessibility**
- 🎙 **VoiceOver Support**: UI elements have **labels & hints**.
- 🔠 **Dynamic Type Scaling**: **Adjusts text size** based on user preferences.
- 🌕 **High Contrast Mode**: Optimized for **visibility**.

### 🚀 **Performance Optimization**
- ⚡ **Efficient Core Data Fetching**: Uses **@StateObject & @FetchRequest**.
- 📜 **LazyVStack for Scrolling**: Handles **100+ tasks** smoothly.

---

## **Core Data Setup**

### **Core Data Model**

```swift
import Foundation
import CoreData

@objc(Task)
public class TaskItem: NSManagedObject {}

extension TaskItem {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<TaskItem>(entityName: "Task")
    }

    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var taskDescription: String?
    @NSManaged public var priority: String
    @NSManaged public var dueDate: Date?
    @NSManaged public var isCompleted: Bool
}

### Sample data for preview

```swift

import CoreData

struct SampleData {
    static func populateSampleTasks(context: NSManagedObjectContext) {
        let task1 = Task(context: context)
        task1.id = UUID()
        task1.title = "Buy groceries"
        task1.taskDescription = "Milk, eggs, bread"
        task1.priority = "High"
        task1.dueDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        task1.isCompleted = false

        let task2 = Task(context: context)
        task2.id = UUID()
        task2.title = "Complete SwiftUI project"
        task2.taskDescription = "Finish the animations and polish UI"
        task2.priority = "Medium"
        task2.dueDate = Calendar.current.date(byAdding: .day, value: 3, to: Date())
        task2.isCompleted = false

        let task3 = Task(context: context)
        task3.id = UUID()
        task3.title = "Workout"
        task3.taskDescription = "Morning exercise routine"
        task3.priority = "Low"
        task3.dueDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        task3.isCompleted = false

        do {
            try context.save()
        } catch {
            print("Error saving sample data: \(error.localizedDescription)")
        }
    }
}

In preview we can add as below

```swift
SampleData.populateSampleTasks(context: PersistenceController.shared.container.viewContext)



## 📦 **Setup Instructions**

### **📌 Prerequisites**
Ensure you have:
- 🖥 **macOS 14+ (Sonoma)**
- 🛠 **Xcode 16+** (SwiftUI 5, iOS 18)
- 🏎 **Swift 5.10**
- 📱 **iPhone Simulator / Physical Device running iOS 18**

### **📥 Installation**
1️⃣ **Clone the repository**  
```sh
git clone https://github.com/your-repo/task-manager-swiftui.git
cd task-manager-swiftui

2️⃣ **Open the project in Xcode**
```sh
open TaskManager.xcodeproj

3️⃣ **Run the app**
Select any simulator 
Press Cmd + R to build and Run


## ** Design Rational**

### 1️⃣  **UI Architecture (SwiftUI 5)**

* NavigationStack for modern navigation.
* List & LazyVStack for a performant task list.
* @StateObject & @FetchRequest to manage Core Data efficiently.

### 2️⃣  **Theming & Adaptability**

* Accent color customization allows users to personalize their experience.
* Supports light and dark mode theme.

### 3️⃣  **User Experience (UX)**

* Empty State Design: Encourages engagement when no tasks exist
* Haptic Feedback: Enhances interactions like completion.
* Gestures: Improves usability with swipe actions.

### 4️⃣ **Animations & Transitions**

* Subtle scaling effects for adding/removing tasks.
* Smooth progress ring updates for task completion.

### 5️⃣ **Accessibility & Inclusive Design**

* VoiceOver support ensures visually impaired users can navigate the app.
* Dynamic Type & High Contrast ensure readability for all users.

## ✅ **Testing**

### UI Tests: 
* Verify the task creation flow.
* Verify the sorting and filtering functionality
