class Post < ApplicationRecord

  belongs_to :admin
  has_many :add_infomations, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  def bookmarked_by?(admin)
    bookmarks.where(admin_id: admin.id).exists?
  end

  attachment :image

end
