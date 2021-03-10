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
    # 入力が空文字の場合
    if content == ''
       Guest.all
    else
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
  end

  def self.name_search_for(content, method)
    # 入力が空文字の場合
    if content == ''
       Guest.all
    else
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

  # 並び替え機能実装
  def self.sort_by_params(keyword)
    if keyword == 'new'
      order(created_at: :desc)
    elsif keyword == 'old'
      order(:created_at)
    elsif keyword == 'many'
      # joins=>外部キーのguest_idを使用しpostsテーブルとguestsテーブルを結合
      # =>投稿数を数えて投稿の多い順に並び替え
      joins(:posts).merge(Post.group(:guest_id).order(Arel.sql('count(guest_id) desc')))
    else
      # =>投稿数を数えて投稿の少ない順に並び替え
      joins(:posts).merge(Post.group(:guest_id).order(Arel.sql('count(guest_id) asc')))
    end
  end

end