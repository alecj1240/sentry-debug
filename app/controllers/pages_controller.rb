class PagesController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'
  def index
    if user_signed_in?
      redirect_to token_path if current_user.sentry_token.nil?
      @sentryErrors = current_user.sentryerrors
=begin
      uri = URI.parse("https://www.googleapis.com/customsearch/v1?q=NoMethodError+update&cx=001638859173749984711:glesaa6k8uo&key=AIzaSyBQBjc5W-ACdzZW3zK_eq48s4NbwGrEWLQ")
      request = Net::HTTP::Get.new(uri)
      req_options = {
        use_ssl: uri.scheme == "https",
      }
      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
      @googleResults = JSON.parse(response.body)
      puts @googleResults
=end

    end
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
