class BookmarksController < ApplicationController

  def create
    @guest = Guest.find(params[:guest_id])
    # 非同期通信実装のため上記の記述をguest→@guestに変更
    bookmark = current_admin.bookmarks.new(guest_id: @guest.id)
    bookmark.save
    # redirect_to guests_path(guest)
    # 非同期通信実装のため上記の記述を削除
  end

  def destroy
    @guest = Guest.find(params[:guest_id])
    # 非同期通信実装のため上記の記述をguest→@guestに変更
    bookmark = current_admin.bookmarks.find_by(guest_id: @guest.id)
    bookmark.destroy
    # redirect_to guests_path(guest)
    # 非同期通信実装のため上記の記述を削除
  end

end