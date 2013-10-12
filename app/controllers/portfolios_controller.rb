class PortfoliosController < ApplicationController
  # Apply filter to make sure only a logged in user can edit their portfolio
  before_filter :authenticate_user!, :except => [:index, :show]
  
  def index
    
  end
  
  def show
   @user = current_user
   @Portfolio = Portfolio.all
  end
  
  def new
    
  end
  
  def create
    
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
end
