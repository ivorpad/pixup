class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  validates_presence_of :name

  has_many :categorizations, dependent: :destroy
  has_many :projects, through: :categorizations
  has_many :assets, source: 'asset', inverse_of: :category

  scope :global, -> { where( global: true ) }

  def self.categories_for(project)
    global = Category.where(:global => true)
    no_global = project.categories.where(:global => false)
    global.concat(no_global)
  end

end
