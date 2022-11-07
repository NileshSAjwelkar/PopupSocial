class LinksController < ApplicationController
  
  def show
    @link = Link.find_by_slug(params[:slug]) 
    render 'errors/404', status: 404 if @link.nil?
    redirect_to @link.url
  end
end
