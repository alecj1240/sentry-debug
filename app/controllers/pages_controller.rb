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
end
