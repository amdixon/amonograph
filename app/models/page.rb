class Page < ActiveRecord::Base
  attr_accessible :file, :position, :title, :portfolio_id
  
  # Associate pages with appropriate portfolio
  belongs_to :portfolio
  
  # Uploader for adding pages to a portfolio
  mount_uploader :file, FileUploader
end
