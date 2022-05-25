50.times do
  User.create(name: Faker::Name.name, email: Faker::Internet.email, password: "123", avatar_url: "https://cspromogame.ru//storage/upload_images/avatars/#{rand(800..810)}.jpg")
end

100.times do
  Question.create(user_id: rand(1..User.count), body: Faker::Lorem.sentence, solved: [true, false].sample)
end

500.times do
  Answer.create(user_id: rand(1..User.count), question_id: rand(1..Question.count), body: Faker::Lorem.sentence)
end

2000.times do
  target = nil
  id = nil
  case rand(1..2)
  when 1
    target = "Q"
    id = Question.count
  when 2
    target = "A"
    id = Answer.count
  end

  emoji = case rand(1..2)
  when 1
    Emoji.find_by_alias('thumbsup').name
  when 2
    Emoji.find_by_alias('hankey').name
  end
  Like.create(user_id: rand(1..User.count), target_id: rand(1..id), target_type: target, emoji: Emoji.find_by_alias(emoji).name)
end
