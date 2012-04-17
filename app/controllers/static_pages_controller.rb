class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @klink = current_user.klinks.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      login = login_flickr
    end
  end

  def help
  end

  def about
  end
end
