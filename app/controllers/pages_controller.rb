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
    @question_id = link.to_s.split('/')[4]
      if @question_id.to_i != 0
        uri = URI.parse("https://api.stackexchange.com/2.2/questions/#{@question_id}/answers?order=desc&sort=activity&site=stackoverflow")
        request = Net::HTTP::Get.new(uri)
        req_options = {
          use_ssl: uri.scheme == "https",
        }
        response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
          http.request(request)
        end

        answersHash = JSON.parse(response.body)
        if !answersHash["items"].nil?
          counter = 0
          @answerInfo = Array.new
          answersHash["items"].each do |item|
            if item["is_accepted"].to_s == "true"
              @accepted = 1
            else
              @accepted = 0
            end
            @answerInfo.push([@accepted, link + "#" + "#{item['answer_id'].to_s}"])
            @answerInfo = @answerInfo.sort_by{|b| -b[0]}
          end
        return @answerInfo
      end
    end
  end
  helper_method :get_answer
end
