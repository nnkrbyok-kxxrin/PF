class Admin < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tasks, dependent: :destroy
  has_many :guests, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :tags, dependent: :destroy

  # ゲストログイン機能実装
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |admin|
      # パスワードはランダム
      admin.password = SecureRandom.urlsafe_base64
    end
  end

end