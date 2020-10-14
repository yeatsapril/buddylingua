# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "open-uri"

Match.destroy_all
User.destroy_all
Language.destroy_all
Gender.destroy_all
Interest.destroy_all


languages = []
LANGUAGE_NAMES = %w[croatian danish english french german italian lithuanian norwegian polish russian spanish swedish].freeze
puts "Creating Languages..."
LANGUAGE_NAMES.each do |language|
  languages << Language.create(name: language)
end

interests = []
INTEREST_NAMES = %w[animals art books carpenting culture films food gaming gardening socializing sports technology travelling].freeze
puts "Creating interets..."
INTEREST_NAMES.each do |interest|
  interests << Interest.create(name: interest)
end

genders = []
GENDERS = %w[female male non-binary other].freeze
puts "Creating genders..."
GENDERS.each do |gender|
  genders << Gender.create(name: gender)
end

# Cloudinary links
name_anders      = URI.open('https://res.cloudinary.com/dh27aoc3s/image/upload/v1602508840/anders_aya4mx.jpg')
name_jacqueline  = URI.open('https://res.cloudinary.com/dh27aoc3s/image/upload/v1602508839/jacqueline_lairdg.jpg')
name_monika      = URI.open('https://res.cloudinary.com/dh27aoc3s/image/upload/v1602508839/monika_hi58s1.jpg')
name_klaus       = URI.open('https://res.cloudinary.com/dh27aoc3s/image/upload/v1602508840/klaus_fv0wac.jpg')
name_sofia       = URI.open('https://res.cloudinary.com/dh27aoc3s/image/upload/v1602508839/sofia_lso3y6.jpg')
name_torstein    = URI.open('https://res.cloudinary.com/dh27aoc3s/image/upload/v1602508840/torstein_cnn7al.jpg')
name_torstein    = URI.open('https://res.cloudinary.com/dh27aoc3s/image/upload/v1602508840/torstein_cnn7al.jpg')
name_karolina    = URI.open('https://res.cloudinary.com/dh27aoc3s/image/upload/v1602508838/karolina_ifw9kp.jpg')
name_tomek       = URI.open('https://res.cloudinary.com/dh27aoc3s/image/upload/v1602508840/tomek_bo0fwg.jpg')
name_gabriella   = URI.open('https://res.cloudinary.com/dh27aoc3s/image/upload/v1602508839/gabriella_tqfqdc.jpg')
name_xavier      = URI.open('https://res.cloudinary.com/dh27aoc3s/image/upload/v1602508840/xavier_pz81k6.jpg')
name_matis       = URI.open('https://res.cloudinary.com/dh27aoc3s/image/upload/v1602508838/matis_elguru.jpg')
name_sergey      = URI.open('https://res.cloudinary.com/dh27aoc3s/image/upload/v1602514024/sergei_ivkzrf.jpg')
name_ebba        = URI.open('https://res.cloudinary.com/dh27aoc3s/image/upload/v1602508838/ebba_zwgo5f.jpg')
name_olivia      = URI.open('https://res.cloudinary.com/dh27aoc3s/image/upload/v1602508838/olivia_zpsgtq.jpg')
name_aleksandra  = URI.open('https://res.cloudinary.com/dh27aoc3s/image/upload/v1602508838/alekdsandra_sjy6yx.jpg')

puts "Creating Iza our test user..."

User.create(
  name: "Iza",
  email: "test@test.com",
  password: "123456",
  age: "19",
  address: "Lillehammer, Norway",
  gender: genders[0],
  native_language: languages[10],
  target_language: languages[7],
  target_language_level: "2",
  description: "Hello, my name is Iza and I am here to learn Norwegian. Feel free to contact me at any time!")

puts "Test user created! email is test@test.com and pwd is 123456"


puts "Creating real users..."

anders = User.new(
  name: "Anders",
  email: "anders.johansen@gmail.com",
  password: "123456",
  age: "31",
  address: "Bergen, Norway",
  gender: genders[1],
  native_language: languages[7],
  target_language: languages[8],
  target_language_level: "4",
  description: "Hi everyone! I want to learn Polish, and I'd be happy to teach you my native language which is Norwegian 😀")

  anders.photo.attach(io: name_anders, filename: 'anders.jpg', content_type: 'image/jpg')
  anders.save
  puts "Completed user #{User.last.name}!"


jacqueline = User.new(
  name: "Jacqueline",
  email: "jacqueline1275@yahoo.fr",
  password: "123456",
  age: "23",
  address: "Paris, France",
  gender: genders[0],
  native_language: languages[3],
  target_language: languages[11],
  target_language_level: "3",
  description: "Je m'appelle Jacqueline, J'habite à Paris. Enchanté de faire votre connaissance!")

  jacqueline.photo.attach(io: name_jacqueline, filename: 'jacqueline.jpg', content_type: 'image/jpg')
  jacqueline.save
  puts "Completed user #{User.last.name}!"


monika = User.new(
  name: "Monika",
  email: "monika.wisniewska@02.com",
  password: "123456",
  age: "32",
  address: "Warsaw, Poland",
  gender: genders[0],
  native_language: languages[8],
  target_language: languages[10],
  target_language_level: "4",
  description: "Hi my name is Monika! I am a friendly and easy-going person. Please let me assist you with learning the Polish language 🙂")

  monika.photo.attach(io: name_monika, filename: 'monika.jpg', content_type: 'image/jpg')
  monika.save
  puts "Completed user #{User.last.name}!"

klaus = User.new(
  name: "Klaus",
  email: "t_brian_2010@gmail.com",
  password: "123456",
  age: "27",
  address: "Glandorf, Germany",
  gender: genders[1],
  native_language: languages[4],
  target_language: languages[3],
  target_language_level: "1",
  description: "Hello, my name is Klaus and I come from Berlin. I'd like to learn French on the basic level.")

  klaus.photo.attach(io: name_klaus, filename: 'klaus.jpg', content_type: 'image/jpg')
  klaus.save
  puts "Completed user #{User.last.name}!"


sofia = User.new(
  name: "Sofia",
  email: "sofia.turgieniev@gmail.com",
  password: "123456",
  age: "22",
  address: "Sochi, Russia",
  gender: genders[0],
  native_language: languages[9],
  target_language: languages[0],
  target_language_level: "1",
  description: "Hi everyone, my name is Sofia and I come from Sochi. I am happy to help you with learning Russian language.")

  sofia.photo.attach(io: name_sofia, filename: 'sofia.jpg', content_type: 'image/jpg')
  sofia.save
  puts "Completed user #{User.last.name}!"


torstein = User.new(
  name: "Torstein",
  email: "m_torstein_786@hotmail.com",
  password: "123456",
  age: "25",
  address: "Trondheim, Norway",
  gender: genders[1],
  native_language: languages[7],
  target_language: languages[4],
  target_language_level: rand(1..3),
  description: "Hello! I am a Norwegian guy looking to improve my German language skills")

  torstein.photo.attach(io: name_torstein, filename: 'torstein.jpg', content_type: 'image/jpg')
  torstein.save
  puts "Completed user #{User.last.name}!"


karolina = User.new(
  name: "Karolina",
  email: "szcepaniak.karolina@gmail.com",
  password: "123456",
  age: "21",
  address: "Oslo, Norway",
  gender: genders[0],
  native_language: languages[8],
  target_language: languages[7],
  target_language_level: "3",
  description: "Hello! My name is Karolina and I'm a Polish student currently living in Norway. I'm free during the weekends and it'd be great to meet you in person if you're too living in Oslo!" )

  karolina.photo.attach(io: name_karolina, filename: 'karolina.jpg', content_type: 'image/jpg')
  karolina.save
  puts "Completed user #{User.last.name}!"


tomek = User.new(
  name: "Tomek",
  email: "tomasz.kulig@wp.com",
  password: "123456",
  age: "28",
  address: "Warszawa, Poland",
  gender: genders[1],
  native_language: languages[8],
  target_language: languages[10],
  target_language_level: "5",
  description: "Hello! My name is Tomasz but my friends call me Tomek. I am happy to help you with learning the Polish language!")

  tomek.photo.attach(io: name_tomek, filename: 'tomek.jpg', content_type: 'image/jpg')
  tomek.save
  puts "Completed user #{User.last.name}!"


gabriella = User.new(
  name: "Gabriella",
  email: "corleone.gabriella@gmail.com",
  password: "123456",
  age: "26",
  address: "Montebuono, Italy",
  gender: genders[0],
  native_language: languages[5],
  target_language: languages[4],
  target_language_level: "3",
  description: "Il mio nome è Gabriella. Vengo dall’Italia. Piacere!")

  gabriella.photo.attach(io: name_gabriella, filename: 'gabriella.jpg', content_type: 'image/jpg')
  gabriella.save
  puts "Completed user #{User.last.name}!"


xavier = User.new(
  name: "Xavier",
  email: "xavier.laguna@hotmail.com",
  password: "123456",
  age: "26",
  address: "Barcelona, Spain",
  gender: genders[1],
  native_language: languages[10],
  target_language: languages[6],
  target_language_level: rand(1..3),
  description: "Hola! Me nombre es Xavier, pero todos me llaman Sasha. Soy de los Barcelona. Encantado de conocerte!")

  xavier.photo.attach(io: name_xavier, filename: 'xavier.jpg', content_type: 'image/jpg')
  xavier.save
  puts "Completed user #{User.last.name}!"


matis = User.new(
  name: "Matis",
  email: "matis_1990@gmailmail.com",
  password: "123456",
  age: "23",
  address: "Vilnius, Lithuania",
  gender: genders[1],
  native_language: languages[6],
  target_language: languages[10],
  target_language_level: "3",
  description: "I am a Lithuanian student currently living in Vilnius. I have grown up with English and Lithuanian, and I am fluent in all two langauges. I am also conversational in Spanish.")

  matis.photo.attach(io: name_matis, filename: 'matis.jpg', content_type: 'image/jpg')
  matis.save
  puts "Completed user #{User.last.name}!"


sergey = User.new(
  name: "Sergey",
  email: "sergey.tomatov@gmailmail.com",
  password: "123456",
  age: "28",
  address: "Moscow, Russia",
  gender: genders[1],
  native_language: languages[9],
  target_language: languages[1],
  target_language_level: "2",
  description: "I'm a Russian guy currently living in Moscow. I'm planning to move to Copenhagen soon and I'm looking for language partners fluent in Danish.")

  sergey.photo.attach(io: name_sergey, filename: 'sergey.jpg', content_type: 'image/jpg')
  sergey.save
  puts "Completed user #{User.last.name}!"


ebba = User.new(
  name: "Ebba",
  email: "ebba67434@hotmail.com",
  password: "123456",
  age: "23",
  address: "Malmö, Sweden",
  gender: genders[0],
  native_language: languages[11],
  target_language: languages[3],
  target_language_level: "5",
  description: "Hi, my name is Ebba and I come from Sweden. I make friends quickly and can talk with you about pretty much anything 🙃 I'm here to practice my French.")

  ebba.photo.attach(io: name_ebba, filename: 'ebba.jpg', content_type: 'image/jpg')
  ebba.save
  puts "Completed user #{User.last.name}!"


olivia = User.new(
  name: "Olivia",
  email: "johnson.olivia@hotmail.com",
  password: "123456",
  age: "31",
  address: "Manchester, UK",
  gender: genders[0],
  native_language: languages[2],
  target_language: languages[4],
  target_language_level: "1",
  description: "Hello! My name is Olivia I'm an Italian translator currently living in Manchaster. I'd like to learn German. Feel free to contact me if you're interested in a language exchange 😃" )

  olivia.photo.attach(io: name_olivia, filename: 'olivia.jpg', content_type: 'image/jpg')
  olivia.save
  puts "Completed user #{User.last.name}!"


aleksandra = User.new(
  name: "Aleksandra",
  email: "aleksandra.woszczyk@gmail.com",
  password: "123456",
  age: "26",
  address: "Lublin, Poland",
  gender: genders[0],
  native_language: languages[9],
  target_language: languages[7],
  target_language_level: "4",
  description: "Hi! My name is Ola and I am currently living in Lublin, Poland. I joined BuddyLingua to practice my Russian language. Nice to meet you all 😎")

  aleksandra.photo.attach(io: name_aleksandra, filename: 'aleksandra.jpg', content_type: 'image/jpg')
  aleksandra.save
  puts "Completed user #{User.last.name}!"


  puts "Generating intrests..."
  User.all.each do |user|
  interests.sample(4).each do |interest|
  UserInterest.create(
  user_id: user.id,
  interest_id: interest.id
  )
  end
  end

puts "Seeds finished!"

