# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

User.destroy_all
Match.destroy_all

puts 'Creating 10 fake users..'
10.times do
  User.create(
    name: Faker::Name.first_name,
    email: Faker::Internet.email,
    password: 'passwords',
    age: rand(18..40),
    address: %w[Songsvann Ekeberg Frognerseter Østmarka Ullevålseter Vettakollen Holmenkollen Frysja Maridalsvannet Kolsåstoppen Bygdøy Nøklevannet].sample,
    gender: Gender.create(name: Gender::GENDER.sample),
    native_language: Language.create(name: Language::LANGUAGE.sample),
    target_language: Language.create(name: Language::LANGUAGE.sample),
    target_language_level: rand(1..6),
    description: Faker::Lorem.paragraphs
    )

  puts "Completed user #{User.last.name}!"
end


