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
Language.destroy_all

languages = []
LANGUAGE_NAMES = %w[english spanish french german italian norwegian swedish danish polish lithuanian croatian russian].freeze
puts "creating Languages.."
LANGUAGE_NAMES.each do |language|
  languages << Language.create(name: language)
end

interests = []
INTEREST_NAMES = %w[food technology animals travelling books gaming art gardening carpenting films sports culture socializing].freeze
puts "Creating interets.."
INTEREST_NAMES.each do |interest|
  interests << Interest.create(name: interest)
end

genders = []
GENDERS = %w[female male non-binary other].freeze
puts "Creating genders.."
GENDERS.each do |gender|
  genders << Gender.create(name: gender)
end

puts 'Creating 10 fake users..'
10.times do
  User.create(
    name: Faker::Name.first_name,
    email: Faker::Internet.email,
    password: 'passwords',
    age: rand(18..40),
    address: %w[Songsvann Ekeberg Frognerseter Østmarka Ullevålseter Vettakollen Holmenkollen Frysja Maridalsvannet Kolsåstoppen Bygdøy Nøklevannet].sample,
    gender: genders.sample,
    native_language: languages.sample,
    target_language: languages.sample,
    target_language_level: rand(1..6),
    description: Faker::Lorem.paragraphs
    )

  puts "Completed user #{User.last.name}!"
end

puts "Assigning user interests"

User.all.each do |user|
  interests.sample(3).each do |interest|
  UserInterest.create(
  user_id: user.id,
  interest_id: interest.id
  )
end
end

puts "Creating Iza our test user"

User.create(  name: 'Iza',
    email: 'test@test.com',
    password: '123456',
    age: rand(18..40),
    address: %w[Songsvann Ekeberg Frognerseter Østmarka Ullevålseter Vettakollen Holmenkollen Frysja Maridalsvannet Kolsåstoppen Bygdøy Nøklevannet].sample,
    gender: genders.sample,
    native_language: languages.sample,
    target_language: languages.sample,
    target_language_level: rand(1..6),
    description: Faker::Lorem.paragraphs)

puts "Test user created! email is test@test.com and pwd is 123456"
