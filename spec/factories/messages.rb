FactoryGirl.define do
  factory :message do
    user nil
    chat_room nil
    user_references "MyString"
    content "MyText"
  end
end
