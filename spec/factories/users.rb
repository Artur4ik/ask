FactoryBot.define do
  factory :user do
    name { }
    email { "#{name}@factory.bot" }
    password { "123456" }
  end
end
