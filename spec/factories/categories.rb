FactoryGirl.define do
  factory :category do
    name Faker::Lorem.word
    access_count 1

    factory :category_with_articles do
      after(:build) do |category|
        category.articles << FactoryGirl.create(:article, category: category)
      end
    end
  end
end
