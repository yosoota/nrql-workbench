class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include ERB::Util

  before_action do
    raise "ENV['ACCOUNT_ID'] is nil" if ENV['ACCOUNT_ID'].blank?
    raise "ENV['QUERY_KEY'] is nil" if ENV['QUERY_KEY'].blank?
    raise "ENV['INSERT_KEY'] is nil" if ENV['INSERT_KEY'].blank?
  end

end
