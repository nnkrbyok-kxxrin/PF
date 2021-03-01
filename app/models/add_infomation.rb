class AddInfomation < ApplicationRecord

  belongs_to :admin
  belongs_to :post

  attachment :image

end
