class Post < ApplicationRecord

  belongs_to :admin
  belongs_to :guest

  attachment :image

  validates :infomation, presence: true

end
