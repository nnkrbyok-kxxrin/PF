# class PostsController < ApplicationController
  
#   before_action :set_guest, only: [:edit, :update]
#   before_action :set_post, only: [:edit, :update, :destroy]
#   before_action :set_tags, only: [:create, :update]

#   def create
#     guest = Guest.find(params[:guest_id])
    
#     # 本来はPost => SurgeryHistoryなどに命名すべきだった
#     # sugery_history = current_admin.surgery_histories.new(***)
    
#     # write = Post.new(post_params)
#     # write.admin_id = current_admin.id
#     # 上記と下記は同じ意味
#     sugery_history = current_admin.posts.new(post_params)
#     sugery_history.guest_id = guest.id
#     if sugery_history.save
#       sugery_history.save_tags(@tags)
#       redirect_to guest_path(guest.id)
#     else @guest = guest
#         @post = sugery_history
#         @posts = @guest.posts.page(params[:page]).reverse_order.per(1)
#         render 'guests/show'
#     end
#   end

#   def edit
#     @tag_list = @post.tags.pluck(:tag_name).join(',')
#   end

#   def update
#     if @post.update(post_params)
#       @post.save_tags(@tags)
#       redirect_to guest_path(@guest.id)
#     else
#       # エラーメッセージを表示させた際に以前の情報をフォームに入れておくのであれば以下のコメントアウトを外す
#       # @post = Post.find(params[:id])
#       @tag_list = @post.tags.pluck(:tag_name).join(',')
#       render :edit
#     end
#   end

#   def destroy
#     @post.destroy!
#     redirect_to guest_path(params[:guest_id])
#   end

#   private

#   def post_params
#     params.require(:post).permit(:admin_id, :guest_id, :image, :date_and_time, :infomation, :rate)
#   end
  
#   def set_guest
#     @guest = current_admin.guests.find(params[:guest_id])
#   end
  
#   def set_post
#     @post = current_admin.posts.find(params[:id])
#   end
  
#   def set_tags
#     # タグ機能追加
#     # ex:　['tag1, tag2, tag3'] => ['tag1', 'tag2', 'tag3']
#     @tags = params[:post][:tag_name].split(',')
#   end
  
# end