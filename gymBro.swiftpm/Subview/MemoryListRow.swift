import SwiftUI

struct MemoryListRow: View {
    @ObservedObject var memory: Memory
    @Environment(\.managedObjectContext) private var viewContext // to save the updates
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(memory.name)
                .font(.system(size: 20))
                .fontWeight(.bold)
            
            Text(memory.para)
                .font(.body)
                .foregroundColor(.brown)
            
            HStack {
                Spacer()
                if let date = memory.date {
                    Text("\(date,formatter:dateFormatter)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.white)
        .cornerRadius(8)
        .onReceive(self.memory.objectWillChange) { _ in
            if self.viewContext.hasChanges {
                try? self.viewContext.save()
            }
        }
    }
}

struct MemoryListRow_Previews: PreviewProvider {
    static var previews: some View {
        let testMemory = Memory(context: PersistenceController.preview.container.viewContext)
        testMemory.id = UUID()
        testMemory.name = "Test Memory"
        testMemory.para = "Before you can begin to determine what the composition of a particular paragraph will be, you must first decide on an argument and a working thesis statement for your paper. What is the most important idea that you are trying to convey to your reader? The information in each paragraph must be related to that idea. In other words, your paragraphs should remind your reader that there is a recurrent relationship between your thesis and the information in each paragraph. A working thesis functions like a seed from which your paper, and your ideas, will grow. The whole process is an organic one—a natural progression from a seed to a full-blown paper where there are direct, familial relationships between all of the ideas in the paper."
        testMemory.date = Date()
        return MemoryListRow(memory: testMemory)
            .previewLayout(.fixed(width: 350, height: 200))
            .padding()
    }
}
