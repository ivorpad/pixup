class Asset < ActiveRecord::Base
  include ApplicationHelper
  extend FriendlyId
  friendly_id :title, use: :slugged


  mount_uploader :asset_file, AssetItemUploader

  validates_presence_of :title, :category

  belongs_to :project
  belongs_to :user
  belongs_to :category
end
