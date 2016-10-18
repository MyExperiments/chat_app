#
# HomeController
#
# @author sufinsha
#
class HomeController < ApplicationController
  # GET#index /home
  def index
    @users = User.where.not(id: current_user.id)
  end
end
