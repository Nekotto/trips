class Admin::SessionsController < Devise::SessionsController
  layout 'admin'
  
  protected

  def after_sign_in_path_for(resource)
    admin_dashboards_path # ログイン後にリダイレクトするパス
  end

  def after_sign_out_path_for(resource_or_scope)
    new_admin_session_path # ログアウト後にリダイレクトするパス
  end
end