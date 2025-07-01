10.times do
  job = Job.create!(
    title: Faker::Job.title,
    description: Faker::Lorem.paragraph(sentence_count: 3),
    salary: rand(2000..8000),
    category: %w[Transport IT Bucătărie Construcții].sample,
    user: User.first
  )

  image_path = Rails.root.join("app/assets/images/demo_jobs/#{rand(1..5)}.jpg")
  job.images.attach(io: File.open(image_path), filename: "job#{job.id}.jpg", content_type: "image/jpeg")
end
