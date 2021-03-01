class Guest < ApplicationRecord

  belongs_to :admin
  has_many :posts, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  def bookmarked_by?(admin)
    bookmarks.where(admin_id: admin.id).exists?
  end

end
