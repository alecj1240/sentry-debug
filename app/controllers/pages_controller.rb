class PagesController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'
  def index
    if user_signed_in?
      redirect_to token_path if current_user.sentry_token.nil?
      @sentryErrors = current_user.sentryerrors
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

  def show
    if user_signed_in?
      @sentryerror = current_user.sentryerrors.find_by(id: params[:error_id])
    else
      redirect_to unauthorized_path
    end
  end

  def unauthorized
  end

  # function to display the best answer to the user
  def get_answer(link)
    @question_id = link.split('/')[4]
    puts "THE QUESTION ID"
    puts link
    puts @question_id
    puts "THE QUESTION ID"
    uri = URI.parse("https://api.stackexchange.com/2.2/questions/#{@question_id}/answers?order=desc&sort=activity&site=stackoverflow")
    request = Net::HTTP::Get.new(uri)
    req_options = {
      use_ssl: uri.scheme == "https",
    }
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    puts JSON.parse(response.body)
    puts "------------------------"
    puts "------------------------"
    puts "------------------------"
  end
  helper_method :get_answer
end
