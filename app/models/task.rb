class Task < ApplicationRecord

  belongs_to :admin

  validates :body, presence: true, length: { in: 2..50 }

end