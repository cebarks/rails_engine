FactoryBot.define do
  factory :customer do
    sequence :first_name do |n|
      "Customer First Name #{n}"
    end
    
    sequence :last_name do |n|
      "Customer Last Name #{n}"
    end
  end
end
