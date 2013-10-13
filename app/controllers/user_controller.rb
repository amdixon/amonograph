class UserController < ApplicationController

  def index
  end

  def show
    user = User.find_by_name(params[:name]) || not_found
    lookup = user.access_token
    client = DropboxClient.new(lookup)
    data = client.metadata('/')

    @pages = []

    data['contents'].each do |d|
      @pages << d['path']
    end

  end


  private

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end


end
