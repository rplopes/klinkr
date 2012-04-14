class KlinksController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  def create
    @klink = current_user.klinks.build(params[:klink])
    if @klink.save
      flash[:success] = "You have successfully klinked!"
      redirect_to root_path
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @klink.destroy
    redirect_back_or root_path
  end

  private

    def correct_user
      @klink = current_user.klinks.find_by_id(params[:id])
      redirect_to root_path if @klink.nil?
    end
end