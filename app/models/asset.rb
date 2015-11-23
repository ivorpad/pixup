class Asset < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  validates_presence_of :title, :category

  belongs_to :project
  belongs_to :user
  belongs_to :category
end
