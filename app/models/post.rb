class Post < ActiveRecord::Base
  belongs_to :author, :class_name => 'User', :foreign_key => "user_id"
  belongs_to :section
  validates_presence_of :title, :body, :author, :section
  has_friendly_id :title, :use_slug => true
end

class String
  def to_html
    RedCloth.new(self).to_html
  end
end
