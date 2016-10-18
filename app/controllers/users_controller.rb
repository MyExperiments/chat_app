#
# UsersController
#
# @author rashid
#
class UsersController < ApplicationController
  # GET#index /home
  def index
    @user = User.search_users(params[:email], current_user)
    @userlist = render_to_string('_user_list', formats: [:html], layout: false, locals: { users: @user })
    respond_to do |format|
      format.html
      format.json { render json: { html: @userlist } }
    end
  end
end
