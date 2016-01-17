class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates_presence_of :name

  has_many :categorizations, dependent: :destroy
  has_many :projects, through: :categorizations
  has_many :assets, source: 'asset', inverse_of: :category

  scope :global, -> { where( global: true ) }
  # scope :categories_for, -> (project) { project ? joins(:categorization).where('categories.global' => true) : all }
end
