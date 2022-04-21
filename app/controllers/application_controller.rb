class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  # サインアップ後のリダイレクト テスト後
  def after_user_registration_path_for(resource)
    user_path(current_user.id) # 詳細へ
  end

  # サインイン後に転送されるページ(devise用)
  def after_sign_in_path_for(resource)
    user_path(current_user.id) # 詳細へ
  end

  # サインアウト後に転送されるページ(devise用)
  def after_sign_out_path_for(resource)
    root_path
  end

  private
  # nameの入力データを保存(devise用)
   def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up,keys:[:email])
   end

end
