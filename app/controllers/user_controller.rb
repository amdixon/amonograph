class UserController < ApplicationController

  def index
  end

  def show
    @user = User.find_by_name(params[:name]) || not_found
  end


  private

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end


end
