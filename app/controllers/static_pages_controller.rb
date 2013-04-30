class StaticPagesController < ApplicationController
  def home
    if params[:set_locale]
      redirect_to root_path(locale: params[:set_locale])
    end
    if signed_in?
      @microblog = current_user.microblogs.build 
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
	end
	
  def help
  end

  def about
  end

  def contact
  end
end
