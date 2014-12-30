FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }

    trait :confirmed do
      confirmed_at Time.now
    end

    initialize_with do
      if User.where(:email => email).first
        User.where(:email => email).first
      else
        User.create(:email => email, :password => password)
      end
    end
  end
end
