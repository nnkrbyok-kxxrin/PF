class Bookmark < ApplicationRecord

  belongs_to :admin
  belongs_to :post

end
