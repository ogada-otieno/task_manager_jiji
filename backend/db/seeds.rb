# Create 3 sample tasks
Task.create!(
  title: "Complete Ruby on Rails assignment",
  description: "Implement a Task Manager API with Rails",
  completed: false
)

Task.create!(
  title: "Learn React",
  description: "Complete React frontend tutorial",
  completed: true
)

Task.create!(
  title: "Buy groceries",
  description: "Milk, eggs, bread, and vegetables",
  completed: false
)

puts "Sample tasks created successfully!"