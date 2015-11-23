class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :categorizations, dependent: :destroy
  has_many :projects, through: :categorizations
  has_many :assets, source: 'asset', inverse_of: :category

end
