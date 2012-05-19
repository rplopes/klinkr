# require 'rubygems'
# require 'flickraw'
require 'open-uri'
class KlinksController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy, :show]
  before_filter :correct_user,   only: :destroy

  def index
    if signed_in?
      respond_to do |format|
        format.json  { render :json => Klink.all }
      end
    end
  end

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

    latitudes = [39, 52.50, 36]
    longitudes = [-8, -1.5, -115]

    cell = (rand*3).to_i

    @klink.latitude = (latitudes[cell]+rand).to_s
    @klink.longitude = (longitudes[cell]-rand).to_s
    puts @klink.latitude
    puts @klink.longitude
    results = JSON.parse(open("http://maps.googleapis.com/maps/api/geocode/json?latlng=#{@klink.latitude},#{@klink.longitude}&sensor=false").read)["results"][0]["address_components"]
    admin_area = ""
    results.each do |loc|
      if loc["types"][0]=="locality"
        @klink.location = loc["long_name"]
      elsif loc["types"][0]=="administrative_area_level_1"
        admin_area = loc["long_name"]
      elsif loc["types"][0]=="country"
        @klink.country = loc["long_name"]
      end
    end

    if @klink.location == nil
      @klink.location = admin_area
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
    @current_klink = Klink.find_by_id(params[:id])
    if signed_in?
      @klink = current_user.klinks.build
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 9)
      login = login_flickr
    end
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