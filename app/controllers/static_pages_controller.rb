

class StaticPagesController < ApplicationController

  def home
   
    if logged_in?
      @micropost = current_user.microposts.build 
      @feed_items = current_user.feed.paginate(page: params[:page])
      @followers_count = current_user.followers.count
      @following_count = current_user.following.count
    end
  end

  def help
  end

  def about
  end

  def contact
  end


  

end
