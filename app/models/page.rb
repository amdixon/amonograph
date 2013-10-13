class Page < ActiveRecord::Base
  
  # Lets users resort portfolio pages using jquery-ui and acts_as_list gem
  acts_as_list
  
  # accessible attributes
  attr_accessible :file, :position, :title, :portfolio_id
  
  # Associate pages with appropriate portfolio
  belongs_to :portfolio
  
  # Define default ordering for the portfolio pages
  default_scope order: 'position'
  
  # Uploader for adding pages to a portfolio
  mount_uploader :file, FileUploader
  
  before_save :save_web_dimensions, :save_mobile_dimensions

  private

    def save_web_dimensions
      geometry = self.file.web.geometry
      if (! geometry.nil?)
        self.web_width  = file.geometry[:width]
        self.web_height = file.geometry[:height]
      end
    end
    
    def save_mobile_dimensions
      if (! geometry.nil?)
        self.mobile_width  = file.geometry[:width]
        self.mobile_height = file.geometry[:height]
      end
    end
  
end
