class Admins::RegistrationsController < Devise::RegistrationsController

  # ゲストログイン機能実装
  before_action :ensure_normal_admin, only: [:update, :destroy]

  def ensure_normal_admin
    if resource.email == 'guest@example.com'
       redirect_to guests_path, alert: '閲覧用アカウントの編集・削除はできません！'
    end
  end

end