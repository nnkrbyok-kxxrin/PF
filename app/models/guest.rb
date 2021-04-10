class Guest < ApplicationRecord

  belongs_to :admin
  has_many :posts, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  validates :name, presence: true
  validates :name_kana, presence: true
  validates :number, presence: true
  validates :phone_number, presence: true
  validates :sex, presence: true
  validates :date_and_time, presence: true

  def bookmarked_by?(admin)
    bookmarks.where(admin_id: admin.id).exists?
  end

  # 検索について
  # ・タグ検索のみの場合（contentは空文字、tag_listは入力あり） => tag_list,keywordのみ実装、その他はスルー
  # ・contentが入力された場合 => content,model,method,keywordは必ず実装
  #   >> tag_listが入力された場合はtag_listも実装し、tag_listが空文字の場合はスルー、タグ検索必須ではない
  # ・content,tag_listが空文字の場合 => keywordのみ実装、その他はスルー
  # ・あらゆる検索条件であっても並び替え機能（keyword）は必ず実装

  def self.content_search_for(guests, content, model, method)
    if model == 'number'
      Guest.number_search_for(guests, content, method)
    else
      Guest.name_search_for(guests, content, method)
    end
  end

  # 下記のguestsは条件検索される結果のこと
  def self.number_search_for(guests, content, method)
    # content入力が空文字の場合
    return guests if content == ''

    if method == 'perfect'
      guests.where(number: content)
    elsif method == 'forward'
      guests.where('number LIKE ?', content + '%')
    elsif method == 'backward'
      guests.where('number LIKE ?', '%' + content)
    else
      guests.where('number LIKE ?', '%' + content + '%')
    end
  end

  # 下記のguestsは条件検索される結果のこと
  def self.name_search_for(guests, content, method)
    # content入力が空文字の場合
    return guests if content == ''

    if method == 'perfect'
      guests.where(name: content)
    elsif method == 'forward'
      guests.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      guests.where('name LIKE ?', '%' + content)
    else
      guests.where('name LIKE ?', '%' + content + '%')
    end
  end

  # 検索機能にタグ検索機能追加
  # 下記のguestsは条件検索された結果のこと
  def self.tag_search_for(guests, tag_list)
    guests.includes(posts: :tags).where(:tags => {:tag_name => tag_list})
  end

  # 検索機能に並び替え機能追加
  # 下記のguestsは条件検索された結果のこと => guests対して並び替えを行う
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