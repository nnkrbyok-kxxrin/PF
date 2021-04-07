class Post < ApplicationRecord

  belongs_to :admin
  belongs_to :guest
  has_many :post_tag_relations
  has_many :tags, through: :post_tag_relations

  attachment :image

  validates :date_and_time, presence: true
  validates :infomation, presence: true

  # レビュー機能
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }, presence: true

  # タグ機能
  def save_tags(savepost_tags)
    # unless..既にこのpost(self)がtagsを持っていたら、self.tags.pl..そのtagsの中のtag_nameというものだけをcurrent_tagsの中に入れる
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    # 古いcurrent_tagsから新しいsavepost_tagsを引いたもの
    old_tags = current_tags - savepost_tags
    # 新しいcurrent_tagsから古いsavepost_tagsを引いたもの
    new_tags = savepost_tags - current_tags

    # 作成
    new_tags.each do |new_name|
      tag = Tag.find_or_create_by(tag_name: new_name)
      self.tags << tag
    end

    # 削除
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag_name: old_name)
    end
  end

end