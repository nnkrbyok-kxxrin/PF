class PostsController < ApplicationController

  def create
    guest = Guest.find(params[:guest_id])
    # write = Post.new(post_params)
    # write.admin_id = current_admin.id
    # 上記と下記は同じ意味
    write = current_admin.posts.new(post_params)
    write.guest_id = guest.id
    write.save
    redirect_to guest_path(guest.id)
  end

  def destroy
    Post.find_by(id: params[:id], guest_id: params[:guest_id]).destroy
    redirect_to guest_path(params[:guest_id])
  end

  private

  def post_params
    params.require(:post).permit(:admin_id, :guest_id, :image, :infomation)
  end

end