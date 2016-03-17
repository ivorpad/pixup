class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  validates_presence_of :name

  has_many :categorizations
  has_many :projects, through: :categorizations

  has_many :assets
  has_many :users

  scope :global, -> { where( global: true ) }

  def should_generate_new_friendly_id?
   name_changed?
  end
end
