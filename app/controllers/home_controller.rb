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

  # GET autocomplete
  def auto_complete_users
    @user = User.search_users(params[:term])
    respond_to do |format|
      format.html
      format.json { render json: @user.map { |x| { email: "#{x.email}", id: x.id } } }
    end
  end
end
