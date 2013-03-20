FactoryGirl.define do
  factory :user do
	email { Faker::Internet.email }
	password { Faker::Lorem.word }
	password_confirmation { password }
  end
end
