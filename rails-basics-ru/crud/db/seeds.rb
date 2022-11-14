10.times do |index|
  Task.create(
    name: "Task #{index}",
    description: "Description is very short for task #{index} but is enough",
    status: ['new','in process','finished'].sample,
    creator: "Person #{index}",
    performer: "Also person but #{index}",
    completed: 'false'
  )
end
