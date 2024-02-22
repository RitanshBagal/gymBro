import SwiftUI

struct NewMemoryView: View {
    @Binding var isShow: Bool
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var benchPress: String = ""
    @State private var squats: String = ""
    @State private var deadlifts: String = ""
    @State private var rows: String = ""
    @State private var pullUps: String = "" // New workout field
    @State private var pushUps: String = "" // New workout field
    @State private var lunges: String = "" // New workout field
    @State private var selectedDate: Date = Date()
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Workout Details").textCase(nil)) {
                        TextField("Bench Press (Sets x Reps)", text: $benchPress)
                            .modifier(TextFieldModifier())
                        
                        TextField("Squats (Sets x Reps)", text: $squats)
                            .modifier(TextFieldModifier())
                        
                        TextField("Deadlifts (Sets x Reps)", text: $deadlifts)
                            .modifier(TextFieldModifier())
                        
                        TextField("Rows (Sets x Reps)", text: $rows)
                            .modifier(TextFieldModifier())
                        
                        TextField("Pull-Ups (Sets x Reps)", text: $pullUps) // New workout field
                            .modifier(TextFieldModifier())
                        
                        TextField("Push-Ups (Sets x Reps)", text: $pushUps) // New workout field
                            .modifier(TextFieldModifier())
                        
                        TextField("Lunges (Sets x Reps)", text: $lunges) // New workout field
                            .modifier(TextFieldModifier())
                    }
                    
                    Section(header: Text("Date Of Workout").textCase(nil)) {
                        DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(.compact)
                    }
                }
                .navigationBarTitle("New Workout", displayMode: .inline)
                .navigationBarItems(
                    trailing: Button(action: {
                        saveWorkout()
                    }) {
                        Text("Save")
                            .fontWeight(.semibold)
                    }
                )
                .padding()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func saveWorkout() {
        let newWorkout = Memory(context: viewContext)
        newWorkout.id = UUID()
        newWorkout.name = "Workout"
        newWorkout.date = selectedDate
        newWorkout.para = """
            Bench Press: \(benchPress)
            Squats: \(squats)
            Deadlifts: \(deadlifts)
            Rows: \(rows)
            Pull-Ups: \(pullUps)
            Push-Ups: \(pushUps)
            Lunges: \(lunges)
        """
        
        do {
            try viewContext.save()
            isShow = false
        } catch {
            print("Error saving workout: \(error.localizedDescription)")
        }
    }
}

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .foregroundColor(.primary)
    }
}

struct NewMemoryView_Previews: PreviewProvider {
    static var previews: some View {
        NewMemoryView(isShow: .constant(true))
    }
}
