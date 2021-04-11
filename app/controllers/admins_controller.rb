class AdminsController < ApplicationController

  # ゲストログイン機能実装
  def guest_sign_in
    admin = Admin.guest
    sign_in admin
    redirect_to guests_path, notice: '閲覧用アカウントでログインしました！（※投稿はPF製作者によって作成されたものです）'
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def update
    @admin = Admin.find(params[:id])
    if @admin.email != 'guest@example.com'
      if @admin.update(admin_params)
      flash.now[:notice] = ''
      redirect_to edit_admin_path(current_admin.id), alert: 'アカウントの設定を更新しました！'
      # redirect_to guests_path
      else
        render :edit
      end
    else
      redirect_to guests_path, notice: '閲覧用アカウントの設定は変更できません！'
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:name, :email)
  end

end