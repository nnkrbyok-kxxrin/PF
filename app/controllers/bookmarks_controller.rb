class BookmarksController < ApplicationController

  def create
    # 非同期通信実装のため下記の記述をguest→@guestに変更
    @guest = Guest.find(params[:guest_id])
    bookmark = current_admin.bookmarks.new(guest_id: @guest.id)
    bookmark.save
    # 非同期通信実装のため下記の記述を削除
    # redirect_to guests_path(guest)
  end

  def destroy
    # 非同期通信実装のため下記の記述をguest→@guestに変更
    @guest = Guest.find(params[:guest_id])
    bookmark = current_admin.bookmarks.find_by(guest_id: @guest.id)
    bookmark.destroy
    # 非同期通信実装のため下記の記述を削除
    # redirect_to guests_path(guest)
  end

end