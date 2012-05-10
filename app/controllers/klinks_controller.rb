# require 'rubygems'
# require 'flickraw'
class KlinksController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy, :show]
  before_filter :correct_user,   only: :destroy

  def create
    @klink = current_user.klinks.build(description: params[:description])
    ok = true
    error = "Something went wrong..."

    begin
      login = login_flickr
      picture_uri = flickr.upload_photo params[:photo].tempfile.path, title: "klink", description: params[:description]
      @klink.picture_uri = picture_uri
    rescue
      ok = false
      error = "Flickr error!"
    end

    if ok and @klink.save
      flash[:success] = "You have successfully klinked!"
      redirect_to root_path
    else
      @feed_items = []
      flash[:error] = error
      redirect_to root_path
    end
  end

  def destroy
    @klink.destroy
    redirect_back_or root_path
  end

  def show
    @klink = Klink.find_by_id(params[:id])
  end

  private

    def correct_user
      @klink = current_user.klinks.find_by_id(params[:id])
      redirect_to root_path if @klink.nil?
    end

    def mega_puts(object)
      puts "\n\n\n\n\n\n\n\n\n\n#{object}\n\n\n\n\n\n\n\n\n\n"
    end
end