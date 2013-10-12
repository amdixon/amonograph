class PagesController < ApplicationController
  def sort
    params[:page].each_with_index do |id, index|
      Page.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end
end
