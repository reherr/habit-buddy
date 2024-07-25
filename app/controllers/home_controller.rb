class HomeController < ApplicationController
  before_action :redirect_if_signed_in

  def index
    # any additional code for your landing page
  end

  private

  def redirect_if_signed_in
    redirect_to habits_path if user_signed_in?
  end
end
