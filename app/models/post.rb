class Post < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :title, :body, :user

  has_friendly_id :title, :use_slug => true
end
