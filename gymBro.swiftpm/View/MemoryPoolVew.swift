import SwiftUI

struct MemoryPoolView: View {
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
//    @State private var selectedMemory: Memory?
//    @State private var isSelected: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(memories.filter { searchText.isEmpty ? true : $0.name.contains(searchText)}) { memory in
                        MemoryListRow(memory: memory)

                    }
                    .onDelete(perform: deleteMemory)

                }
                .listStyle(.sidebar)
                if memories.count == 0 {
                    Image("no-data")
                        .resizable()
                        .scaledToFit()
                }
                
                
            }
            .navigationTitle("Workout")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.showNewMemory = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.accentColor)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                        .foregroundColor(.blue)
                        .opacity(self.memories.count == 0 ? 0.5 : 1)
                        .disabled(self.memories.count == 0)
                }
            }
        }
        .searchable(text: self.$searchText, placement: .automatic)
        .sheet(isPresented: $showNewMemory) {
            NewMemoryView(isShow: self.$showNewMemory)
                .offset(y:30)
        }
    }
    
    private func deleteMemory(index: IndexSet) -> Void {
        withAnimation {
            index.map { memories[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError.localizedDescription), \(nsError.userInfo)")
            }
        }
    }}

#Preview {
   MemoryPoolView()
}
