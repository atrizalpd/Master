class Post < ActiveRecord::Base
# models/product.rb
acts_as_taggable

has_attached_file :photo, :styles => { :small => "150x150>" },
                  :url  => "/assets/posts/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/posts/:id/:style/:basename.:extension"
validates_attachment_presence :photo
validates_attachment_size :photo, :less_than => 5.megabytes
validates_attachment_content_type :photo, :content_type => 'image/jpeg'

has_many :categories
has_many :comments
belongs_to :user

accepts_nested_attributes_for :categories, :allow_destroy => :true ,  :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } } 

acts_as_state_machine :initial => :draft, :column => 'state'
state :publishing
state :draft

event :publish do	
 	transitions :from => :draft, :to => :publishing
	end

event :save_draft do
	transitions :from => :publishing, :to => :draft
	end

named_scope :publish_post, {:conditions => ["state=?", "publishing"]}
named_scope :draft_post, {:conditions => ["state=?", "draft"]}
end
