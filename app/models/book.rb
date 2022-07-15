class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }

  today = Time.current.end_of_day
  last_week = (today - 6.day).beginning_of_day
  scope :created_this_week, -> { where(created_at: last_week...today) }

  last_week_first = (today - 13.day).beginning_of_day
  last_week_end = (today - 7.day).end_of_day
  scope :created_last_week, -> { where(created_at: last_week_first...last_week_end) }
end
