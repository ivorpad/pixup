class Project < ActiveRecord::Base
  extend FriendlyId
  resourcify

  # Unfortunately, Rails 4.2.2 still doesn't have a way to pass a prefix to enums
  # This will be officially added in Rails 5.
  enum status: { is_private: 0, is_public: 1, is_team: 2 }

  friendly_id :title, use: :slugged

  # Validations
  validates_presence_of :title, :description

  # Scope

  # Associations
  has_many :assets, dependent: :destroy
  belongs_to :user

  has_many :collaborations
  has_many :users, through: :collaborations

  has_many :categorizations
  has_many :categories, through: :categorizations

  has_many :posts

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
