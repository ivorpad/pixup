class Project < ActiveRecord::Base
  extend FriendlyId
  resourcify


  friendly_id :title, use: :slugged

  # Validations
  validates_presence_of :title, :description

  # Scope

  scope :list_private, -> { where(private: true)  }

  # Associations
  has_many :assets, dependent: :destroy
  belongs_to :user

  has_many :collaborations
  has_many :users, through: :collaborations

  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations

  accepts_nested_attributes_for :users

  # Returns global and non-global categories
  def visible_categories
    global = Category.where(global: true)
    no_global = categories.where(global: false)
    global.concat(no_global).uniq.sort
  end

  def collaborators
    users.where.not(name: user.name)
  end
end
