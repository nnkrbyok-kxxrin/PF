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

  # 下記のguestsは条件検索される結果のこと
  def self.number_search_for(content, method, sort, tag_list)
    # 入力が空文字の場合
    if content == ''
      # guests = Guest.all
      guests = Guest.includes(posts: :tags).where(:tags => {:tag_name => ['テスト','てすと']}).uniq
      p 'case a'
    else
      if method == 'perfect'
        guests = Guest.where(number: content)
        p 'case b'
      elsif method == 'forward'
        guests = Guest.where('number LIKE ?', content + '%')
        p 'case c'
      elsif method == 'backward'
        guests = Guest.where('number LIKE ?', '%' + content)
        p 'case d'
      else
        guests = Guest.where('number LIKE ?', '%' + content + '%')
        p 'case e'
      end
    end
    self.sort_by_params(guests, sort)
  end

  # 下記のguestsは条件検索される結果のこと
  def self.name_search_for(content, method, sort, tag_list)
    # 入力が空文字の場合
    if content == ''
      # guests = Guest.all
       guests = Guest.includes(posts: :tags).where(:tags => {:tag_name => ['テスト','てすと']}).uniq
    else
      if method == 'perfect'
        guests = Guest.where(name: content)
      elsif method == 'forward'
        guests = Guest.where('name LIKE ?', content + '%')
      elsif method == 'backward'
        guests = Guest.where('name LIKE ?', '%' + content)
      else
        guests = Guest.where('name LIKE ?', '%' + content + '%')
      end
    end
    guests = self.sort_by_params(guests, sort)
  end

  # 検索機能に並び替え機能追加
  # 下記のguestsは条件検索された結果のこと => guests対して並び替えを行う
  # 空文字の場合は全ての投稿に対して並び替え機能のみを実装（controllerで定義）
  def self.sort_by_params(guests, keyword)
    if keyword == 'new'
      guests.order(created_at: :desc)
    elsif keyword == 'old'
      guests.order(:created_at)
    elsif keyword == 'many'
      # joins=>外部キーのguest_idを使用しpostsテーブルとguestsテーブルを結合
      # =>投稿数を数えて投稿の多い順に並び替え
      guests.joins(:posts).merge(Post.group(:guest_id).order(Arel.sql('count(guest_id) desc')))
    else
      # =>投稿数を数えて投稿の少ない順に並び替え
      guests.joins(:posts).merge(Post.group(:guest_id).order(Arel.sql('count(guest_id) asc')))
    end
  end

end



# Guest.includes(posts: :tags).where(:tags => {:tag_name => ['テスト','てすと']}).un