require 'faker'

FactoryBot.define do
  factory :tweet do
    content { Faker::Lorem.paragraph }
    picture { Rack::Test::UploadedFile
      .new(File.open(File.join(Rails.root, '/spec/files/kirby.png'))) }
  end

  factory :user do
    username { Faker::Internet.username }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
