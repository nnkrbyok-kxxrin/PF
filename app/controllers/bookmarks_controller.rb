class BookmarksController < ApplicationController

  def create
    guest = Guest.find(params[:guest_id])
    bookmark = current_admin.bookmarks.new(guest_id: guest.id)
    bookmark.save
    redirect_to guest_path(guest)
  end

  def destroy
    guest = Guest.find(params[:guest_id])
    bookmark = current_admin.bookmarks.find_by(guest_id: guest.id)
    bookmark.destroy
    redirect_to guest_path(guest)
  end

end