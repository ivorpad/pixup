class Project < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Validations
  validates_presence_of :title, :description

  # Associations
  has_many :assets, dependent: :destroy
  belongs_to :user

  has_many :collaborations
  has_many :users, through: :collaborations

  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations
end
