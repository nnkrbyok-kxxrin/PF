class PostsController < ApplicationController

  def create
    guest = Guest.find(params[:guest_id])
    # write = Post.new(post_params)
    # write.admin_id = current_admin.id
    # 上記と下記は同じ意味
    write = current_admin.posts.new(post_params)
    write.guest_id = guest.id
    if write.save
      # タグ機能追加
      # ex:　['tag1, tag2, tag3'] => ['tag1', 'tag2', 'tag3']
       tag_list = params[:post][:tag_name].split(',')
       write.save_tags(tag_list)
       redirect_to guest_path(guest.id)
    else @guest = guest
         @post = write
         @posts = @guest.posts.page(params[:page]).reverse_order.per(1)
         render 'guests/show'
    end
  end

  def edit
    @guest = current_admin.guests.find(params[:guest_id])
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:tag_name).join(',')
  end

  def update
    @guest = current_admin.guests.find(params[:guest_id])
    @post = Post.find(params[:id])
    tag_list = params[:post][:tag_name].split(',')
    if @post.update(post_params)
       @post.save_tags(tag_list)
       redirect_to guest_path(@guest.id)
    else
        render :edit
    end
  end

  def destroy
    Post.find_by(id: params[:id], guest_id: params[:guest_id]).destroy
    redirect_to guest_path(params[:guest_id])
  end

  private

  def post_params
    params.require(:post).permit(:admin_id, :guest_id, :image, :date_and_time, :infomation, :rate)
  end

end