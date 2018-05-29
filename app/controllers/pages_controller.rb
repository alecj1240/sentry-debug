class PagesController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'
  def index
    if user_signed_in?
      redirect_to token_path if current_user.sentry_token.nil?
      
=begin
      uri = URI.parse("https://www.googleapis.com/customsearch/v1?q=NoMethodError+update&cx=001638859173749984711:glesaa6k8uo&key=AIzaSyBQBjc5W-ACdzZW3zK_eq48s4NbwGrEWLQ")
      request = Net::HTTP::Get.new(uri)
      req_options = {
        use_ssl: uri.scheme == "https",
      }
      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
      @googleResults = response.body
      puts @googleResults
=end

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
