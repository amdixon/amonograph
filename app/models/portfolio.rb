class Portfolio < ActiveRecord::Base
  attr_accessible :title, :user_id
  
  # Link to unique user
  belongs_to :user
  
  # User ID valdation
  validates :user_id, presence: true
  
  # Associate pages with user's portfolio
  has_many :pages, :dependent => :destroy

end
