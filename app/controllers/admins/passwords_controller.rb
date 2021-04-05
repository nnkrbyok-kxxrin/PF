class Admins::PasswordsController < Devise::PasswordsController

  # ゲストログイン機能実装
  before_action :ensure_normal_admin, only: :create

  def ensure_normal_admin
    if params[:admin][:email].downcase == 'guest@example.com'
       redirect_to new_admin_session_path, alert: '閲覧用アカウント設定は変更できません！'
    end
    if params[:admin][:name] == 'guest'
       redirect_to new_admin_session_path, alert: '閲覧用アカウント設定は変更できません！'
    end
  end

end