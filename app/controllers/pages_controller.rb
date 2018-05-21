class PagesController < ApplicationController
  def index
    #conn = Faraday.new(:url => "https://app.getsentry.com")
    #@stackResults = conn.get '/api/0/projects/christopher-bot/christopher-bot/events/', { :Authorization => "2ff6957e5241427fa6a6cd4d3d72c964196635870b2c4eac9435ad1e0e18ba19", :Host => "app.getsentry.com" }
    #return @stackResults
  end

  def token
  end
end
