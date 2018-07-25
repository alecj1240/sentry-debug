class PagesController < ApplicationController
  # used for doing the HTTP GET to Stack overflow
  require 'net/http'
  require 'uri'
  # used to parse the data returned by stack overflow into a nice hash
  require 'json'

  def index
    if user_signed_in?
      # check to see if they put in a sentry token.
      redirect_to token_path if current_user.sentry_token.nil?
      # get all the errors that belong to them.
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
    # splitting the link into the seperate parts to extract the question id
    @question_id = link.to_s.split('/')[4]
      # making sure the question id is a number and not text
      if @question_id.to_i != 0
        # Running the question id through the stack overflow API
        # will fetch the answers to the question
        uri = URI.parse("https://api.stackexchange.com/2.2/questions/#{@question_id}/answers?order=desc&sort=activity&site=stackoverflow&filter=withbody")
        request = Net::HTTP::Get.new(uri)
        req_options = {
          use_ssl: uri.scheme == "https",
        }
        response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
          http.request(request)
        end

        # answersHash holds all the data returned by Stack Overflow
        answersHash = JSON.parse(response.body)
        # checking to make sure that there are answers (items) that are returned
        if !answersHash["items"].nil?
          # @answerInfo will host the link to the answer and if it's "got a check mark by stack overflow"
          # note: the check mark means the answer works and is approved by stack overflow
          @answerInfo = Array.new
          answersHash["items"].each do |item|
            # converting the true/false on whether or not the answer is accepted into a number
            # it's turned into a number so that it can be sorted so the best answers are on top
            if item["is_accepted"].to_s == "true"
              @accepted = 1
            else
              @accepted = 0
            end
            @codeBody = item["body"]
            # push the data into the @answerInfo
            @answerInfo.push([@accepted, link + "#" + "#{item['answer_id'].to_s}", @codeBody])
            # sort so the approved answers are on top
            @answerInfo = @answerInfo.sort_by{|b| -b[0]}
          end
        return @answerInfo
      end
    end
  end
  # use the helper method so all this code above can be used in the view
  helper_method :get_answer
end
