class GuestsController < ApplicationController

  def new
    @guest = Guest.new
  end

  def create
    @guest = Guest.new(guest_params)
    @guest.admin_id = current_admin.id
    # if guest_params[:address] == ""
    #   @guest.address = "未記入"
    # end
    # デフォルト値設定
    # 上記の記入は入力が空だった場合、DBに"未記入"と保存される
    # Viewでのif文記述であればDBにnilで保存される
    @guest.save
    redirect_to guests_path
  end

  def index
    # @guests = Guest.all
    # ページング機能実装のため、上記を下記に変更
    @guests = Guest.page(params[:page]).reverse_order

    @task_new = Task.new
    @tasks = Task.all
    @task = Task.find_by(params[:id])
  end

  def show
    @guest = Guest.find(params[:id])
    @post = Post.new
  end

  def edit
    @guest = Guest.find(params[:id])
  end

  def update
    @guest = Guest.find(params[:id])
    @guest.update(guest_params)
    redirect_to guest_path(@guest.id)

  end

  def destroy
    @guest = Guest.find(params[:id])
    @guest.destroy
    redirect_to guests_path
  end

  private

  def guest_params
    params.require(:guest).permit(:name, :name_kana, :number, :phone_number, :address, :birthday, :sex, :allergie, :profession)
  end

end