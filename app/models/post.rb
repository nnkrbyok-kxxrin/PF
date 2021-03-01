class Post < ApplicationRecord

  belongs_to :admin
  belongs_to :guest

  attachment :image

end
