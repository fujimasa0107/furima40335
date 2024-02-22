FactoryBot.define do
  factory :user do
    nickname              { Faker::Internet.username(specifier: 5..10) }
    email                 { Faker::Internet.email }
    password              { '000aaa' }
    password_confirmation { '000aaa' }
    last_name             { '中村' }
    first_name            { '田中' }
    last_name_kana        { 'ナカムラ' }
    first_name_kana       { 'ユタカ' }
    birth_date            { '2024/10/01' }
  end
end
