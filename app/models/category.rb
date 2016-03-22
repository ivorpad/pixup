class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  validates_presence_of :name

  has_many :projects
  has_many :assets, dependent: :destroy
  has_many :posts
  
  belongs_to :user

  scope :global, -> { where( global: true ) }

  def slug_candidates
   [
     :name,
     [:name, :name_sequence]
  ]
  end

  def name_sequence
   slug = normalize_friendly_id(name)
   sequence = Category.where("slug like '#{slug}-%'").count + 2
  end

  def should_generate_new_friendly_id?
   name_changed?
  end
end
