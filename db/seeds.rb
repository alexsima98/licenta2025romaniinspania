require "open-uri"
require "faker"

User.destroy_all

User.create!(
  email: "admin@email.com",
  password: "parola",
  admin: true
  # description: "Cont demo pentru populare",
  # looking_for_job: false
)

user =  User.create!(
  email: "user@email.com",
  password: "parola",
  # description: "Cont demo pentru populare",
  # looking_for_job: false
)

users = []

15.times do
  users << User.create!(
    email: Faker::Internet.unique.email,
    password: "parola",
    # description: Faker::Lorem.sentence(word_count: 10),
    # looking_for_job: [true, false].sample
  )
end

# housings = [
#   {
#     title: "Apartament modern în Barcelona",
#     description: "Apartament spațios, complet mobilat, în centrul orașului Barcelona.",
#     price: 1200,
#     location: "Barcelona",
#     images: ["https://picsum.photos/id/1018/800/600"]
#   },
#   {
#     title: "Garsonieră luminoasă în Valencia",
#     description: "Ideală pentru o persoană sau un cuplu. Aproape de metrou și supermarket.",
#     price: 800,
#     location: "Valencia",
#     images: ["https://picsum.photos/id/1015/800/600"]
#   },
#   {
#     title: "Casă cu 3 dormitoare în Sevilla",
#     description: "Perfectă pentru o familie. Curte mare și grădină privată.",
#     price: 1500,
#     location: "Sevilla",
#     images: ["https://picsum.photos/id/1027/800/600"]
#   },
#   {
#     title: "Studio elegant în Madrid",
#     description: "Situat într-un cartier liniștit, aproape de centrul financiar.",
#     price: 950,
#     location: "Madrid",
#     images: ["https://picsum.photos/id/1032/800/600"]
#   }
# ]



puts "Seeding housing..."

Housing.destroy_all
# housings.each_with_index do |data, index|
#   housing = Housing.create!(
#     title: data[:title],
#     description: data[:description],
#     price: data[:price],
#     location: data[:location],
#     user: user,
#     published: index % 2 == 0
#   )

#   data[:images].each do |image_url|
#     file = URI.open(image_url)
#     housing.images.attach(io: file, filename: File.basename(image_url), content_type: "image/jpeg")
#   end

#   puts "✓ #{housing.title} adăugat"
# end
locations = ["Barcelona", "Valencia", "Sevilla", "Madrid", "Zaragoza", "Bilbao", "Granada", "Malaga"]

25.times do
  housing = Housing.create!(
    title: "#{Faker::Address.community} în #{locations.sample}",
    description: Faker::Lorem.paragraph(sentence_count: 3),
    price: rand(500..2500),
    location: locations.sample,
    published: [true, false].sample,
    user: users.sample
  )

  image_url = "https://picsum.photos/seed/#{rand(1000)}/800/600"
  housing.images.attach(
    io: URI.open(image_url),
    filename: "housing#{housing.id}.jpg",
    content_type: "image/jpeg"
  )

  puts "✓ #{housing.title} adăugat"
end


30.times do |t|
  job = Job.create!(
    title: Faker::Job.title,
    description: Faker::Lorem.paragraph(sentence_count: 3),
    salary: rand(2000..8000),
    category: %w[Transport IT Bucătărie Construcții].sample,
    user: users.sample,
    published: t % 3 == 0
  )

  image_url = "https://picsum.photos/seed/#{rand(1000)}/600/400"
  job.images.attach(io: URI.open(image_url), filename: "job#{job.id}.jpg", content_type: "image/jpeg")

end
