class Admins::SessionsController < Devise::SessionsController
  
  # ゲストログイン機能実装
  def guest_sign_in
    admin = Admin.guest
    sign_in admin
    redirect_to guests_path, notice: '閲覧用アカウントでログインしました！'
  end
  
end