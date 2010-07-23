class Post < ActiveRecord::Base
  PER_PAGE = 5
  include AASM

  default_scope :order => ["created_at DESC"]
  belongs_to :author, :class_name => 'User', :foreign_key => "user_id"
  belongs_to :section
  validates_presence_of :title, :body, :author, :section
  has_friendly_id :title, :use_slug => true
  acts_as_taggable_on :tags
  
  aasm_initial_state :waiting_approval

  aasm_state :waiting_approval
  aasm_state :approved
  
  aasm_event :approve do
    transitions :to => :approved, :from => [:waiting_approval]
  end
end

class String
  def to_html
    RedCloth.new(self).to_html
  end
end
