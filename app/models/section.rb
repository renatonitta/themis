class Section < ActiveRecord::Base
  validates_presence_of :name
  has_many :posts
  has_friendly_id :name, :use_slug => true
end
