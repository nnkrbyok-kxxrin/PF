class GuestsController < ApplicationController

  def new
    @guest = Guest.new
  end

  def create
    @guest = Guest.new(guest_params)
    @guest.admin_id = current_admin.id
    @guest.save
    redirect_to guests_path
  end

  def index
    @guests = Guest.page(params[:page]).reverse_order
  end

  def show
    @guest = Guest.find(params[:id])
    @post = Post.new
  end

  def edit
  end

  def update
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