class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  validates_presence_of :name

  has_many :categorizations
  has_many :projects, through: :categorizations

  has_many :assets

  scope :global, -> { where( global: true ) }

  def self.categories_for(project)
    global = Category.where(:global => true)
    no_global = project.categories.where(:global => false)
    global.concat(no_global)
  end

  def should_generate_new_friendly_id?
   name_changed?
  end
end
