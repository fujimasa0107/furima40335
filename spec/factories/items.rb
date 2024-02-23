FactoryBot.define do
  factory :item do
    name              { Faker::Commerce.product_name }
    description       { Faker::Lorem.sentence(word_count: 10) }
    category_id       { Faker::Number.between(from: 2, to: 10) } # id 1 は "---" などのプレースホルダーで使用されるため
    condition_id      { Faker::Number.between(from: 2, to: 7) }
    shipping_cost_id  { Faker::Number.between(from: 2, to: 3) }
    prefecture_id     { Faker::Number.between(from: 2, to: 48) } # 47都道府県 + "---"
    shipping_date_id  { Faker::Number.between(from: 2, to: 4) }
    price             { Faker::Number.between(from: 300, to: 9_999_999) }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
