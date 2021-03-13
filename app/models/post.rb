class Post < ApplicationRecord

  belongs_to :admin
  belongs_to :guest

  attachment :image

  validates :infomation, presence: true
  
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }, presence: true

end
