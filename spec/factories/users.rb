FactoryGirl.define do
  factory :user do
    # first_name { Faker::Name.first_name }
    # last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    # is_active 1
    # roles 'admin'

    trait :confirmed do
      confirmed_at Time.now
    end

    initialize_with do
      if User.where(:email => email).first
        User.where(:email => email).first
      else
        User.create({
                        :email => email,
                        :password => password
                    })
      end
    end

  end
end