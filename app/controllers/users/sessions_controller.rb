module Users
  #
  # SessionsController
  #
  # @author sufinsha
  #
  class SessionsController < Devise::SessionsController
    include SelectCurrentUser
    protect_from_forgery with: :null_session
    skip_before_action :verify_signed_out_user, only: [:destroy], if: :json_request?

    # before_action :configure_sign_in_params, only: [:create]

    # GET /resource/sign_in
    # def new
    #   super
    # end

    # POST /resource/sign_in
    def create
      respond_to do |format|
        format.html { super }
        format.json do
          sign_in_via_api
        end
      end
    end

    # DELETE /resource/sign_out
    def destroy
      respond_to do |format|
        format.html { super }
        format.json do
          sign_out_via_api
        end
      end
    end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end
    #

    private

    def sign_in_via_api
      @user = User.find_for_database_authentication(email: params[:email])
      if @user && @user.valid_password?(params[:password])
        @user.set_authentication_token && @user.save
        api_sign_in_success
      else
        api_sign_in_failure
      end
    end

    def sign_out_via_api
      set_current_user
      if @current_user.nil?
        api_sign_out_failure
        return
      end
      @current_user.set_authentication_token('')
      if @current_user.save!
        api_sign_out_success
      else
        api_sign_out_failure
      end
    end

    def api_sign_in_success
      @success = true
      @message = I18n.t(:'devise.sessions.signed_in')
    end

    def api_sign_in_failure
      @success = false
      @message = I18n.t(:'devise.failure.invalid', authentication_keys: 'email')
    end

    def api_sign_out_success
      @success = true
    end

    def api_sign_out_failure
      @success = false
    end
  end
end
