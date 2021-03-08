class Guest < ApplicationRecord

  belongs_to :admin
  has_many :posts, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :name, presence: true
  validates :name_kana, presence: true
  validates :number, presence: true
  validates :phone_number, presence: true
  validates :sex, presence: true

  def bookmarked_by?(admin)
    bookmarks.where(admin_id: admin.id).exists?
  end

  def self.number_search_for(content, method)
      if method == 'perfect'
        Guest.where(number: content)
      elsif method == 'forward'
        Guest.where('number LIKE ?', content + '%')
      elsif method == 'backward'
        Guest.where('number LIKE ?', '%' + content)
      else
        Guest.where('number LIKE ?', '%' + content + '%')
      end
  end

  def self.name_search_for(content, method)
      if method == 'perfect'
        Guest.where(name: content)
      elsif method == 'forward'
        Guest.where('name LIKE ?', content + '%')
      elsif method == 'backward'
        Guest.where('name LIKE ?', '%' + content)
      else
        Guest.where('name LIKE ?', '%' + content + '%')
      end
  end

end