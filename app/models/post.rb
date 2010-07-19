class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :author, :class_name => 'User', :foreign_key => "user_id"
  validates_presence_of :title, :body, :user

  has_friendly_id :title, :use_slug => true
end
