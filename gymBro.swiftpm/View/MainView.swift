import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: Memory.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Memory.date, ascending: true)
        ],
        animation: .default
    )
    private var memories: FetchedResults<Memory>
    
    @State private var showNewMemory: Bool = false
    @State private var searchText: String = ""
    @State private var selectedMemory: Memory?
    
    // Properties for gym exercise form
    @State private var benchPress: String = ""
    @State private var squats: String = ""
    @State private var deadlifts: String = ""
    @State private var rows: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                
                List {
                    ForEach(memories) { memory in
                        MemoryListRowView(memory: memory)
                            .onTapGesture {
                                self.selectedMemory = memory
                            }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarTitle("Gym Workout Tracker")
            .navigationBarItems(
                trailing: Button(action: {
                    self.showNewMemory = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.accentColor)
                        .imageScale(.large)
                }
            )
        }
        .sheet(isPresented: $showNewMemory) {
            NewMemoryView(isShow: self.$showNewMemory)
        }
    }
}

struct MemoryListRowView: View {
    var memory: Memory
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(memory.formattedDate)
                .font(.headline)
            Text(memory.formattedDetails)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}

extension Memory {
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: date ?? Date())
    }
    
    var formattedDetails: String {
        var details = para ?? ""
        details = details.replacingOccurrences(of: "\n", with: ", ")
        return details
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
