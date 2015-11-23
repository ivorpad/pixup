class Asset < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, presence: true
  validates :category, presence: true

  belongs_to :project
  belongs_to :user
  belongs_to :category
end
