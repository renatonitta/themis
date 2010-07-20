# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :post do |f|
  f.title "MyString"
  f.body "MyText"
  f.association :author, :factory => :user
  f.association :section
end
