require 'dropbox_sdk'
require 'securerandom'

APP_KEY = "3qkf9rrz8s2wyxk"
APP_SECRET = "aq0dm6aq63fvp4q"

class UserController < ApplicationController

  def index
  end

  def show
    @user = User.find_by_name(params[:name]) || not_found
    lookup = @user.access_token
    client = DropboxClient.new(lookup)
    data = client.metadata('/')

    @pages = []

    data['contents'].each do |d|
     @pages << d['path']
    end

    @images = []

    @pages.each do |p|
      @images << client.media(p)
    end

  end


  private

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end


end
