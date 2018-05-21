class PagesController < ApplicationController
  def index
    if user_signed_in?
      redirect_to token_path if current_user.sentry_token.nil?
    end
    #conn = Faraday.new(:url => "https://app.getsentry.com")
    #@stackResults = conn.get '/api/0/projects/christopher-bot/christopher-bot/events/', { :Authorization => "2ff6957e5241427fa6a6cd4d3d72c964196635870b2c4eac9435ad1e0e18ba19", :Host => "app.getsentry.com" }
    #return @stackResults
  end

  def token
    if !current_user.sentry_token.nil?
      redirect_to root_path
    end
    if !params[:user].nil?
      current_user.update(:sentry_token => params[:user][:sentry_token])
      redirect_to root_path
    end
  end
end
