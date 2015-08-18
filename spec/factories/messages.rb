FactoryGirl.define do
  
  factory :message do
    title { Faker::Lorem.word }
    body { Faker::Lorem.sentence }
    
    factory :invalid_message do
      title nil
    end
  end
end