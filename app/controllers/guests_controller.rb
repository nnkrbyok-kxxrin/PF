class GuestsController < ApplicationController

  def new
    @guest = Guest.new
  end

  def create
    @guest = Guest.new(guest_params)
    @guest.admin_id = current_admin.id
    # controller内でデフォルト値設定する場合
    # if guest_params[:address] == ""
    #   @guest.address = "未記入"
    # end
    # 上記の記入は入力が空だった場合、DBに"未記入"と保存される
    # View内でのif文記述であればDBにnilで保存される => 今回はこちらでデフォルト値を実装
    if @guest.save
        redirect_to guests_path
    else
        render :new
    end
  end

  def index
    # @guests = Guest.all
    # ページング機能実装のため、上記を下記に変更
    # @guests = Guest.page(params[:page]).reverse_order
    # ログインしている人に基づくものしか表示させないため、上記を下記に変更
    @guests = current_admin.guests.page(params[:page]).reverse_order

    @task_new = Task.new
    # @tasks = Task.all
    # ログインしている人に基づくものしか表示させないため、上記を下記に変更
    @tasks = current_admin.tasks.all
    # @task = Task.find_by(params[:id])
    # ログインしている人に基づくものしか表示させないため、上記を下記に変更
    @task = current_admin.tasks.find_by(params[:id])

    # Postのページング・非同期実装のため、下記４行を追記
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    # @guest = Guest.find(params[:id])
    # ログインしている人に基づくものしか表示させないため、上記を下記に変更
    @guest = current_admin.guests.find(params[:id])

    @post = Post.new
    # Postのページング機能実装のため、下記を追記
    @posts = @guest.posts.page(params[:page]).reverse_order.per(1)
  
    # Postのページング・非同期実装のため、下記４行を追記
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    # @guest = Guest.find(params[:id])
    # ログインしている人に基づくものしか表示させないため、上記を下記に変更
    @guest = current_admin.guests.find(params[:id])
  end

  def update
    # @guest = Guest.find(params[:id])
    # ログインしている人に基づくものしか表示させないため、上記を下記に変更
    @guest = current_admin.guests.find(params[:id])
    if @guest.update(guest_params)
        redirect_to guest_path(@guest.id)
    else
        render :edit
    end
  end

  def destroy
    # @guest = Guest.find(params[:id])
    # ログインしている人に基づくものしか表示させないため、上記を下記に変更
    @guest = current_admin.guests.find(params[:id])
    @guest.destroy
    redirect_to guests_path
  end

  private

  def guest_params
    params.require(:guest).permit(:name, :name_kana, :number, :phone_number, :address, :birthday, :sex, :allergie, :profession, :date_and_time)
  end

end