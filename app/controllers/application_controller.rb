class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def login_flickr
    FlickRaw.api_key="5af6d168b822ee7011d012bb4d009d4e"
    FlickRaw.shared_secret="6af84897a9fa97db"
    flickr.access_token = "72157629469841508-be501e56132059ed"
    flickr.access_secret = "8127eae7b2193eb5"

    login = flickr.test.login
  end
end
