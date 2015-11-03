class Project < ActiveRecord::Base

  # Validations
  validates :title, presence: true
  validates :description, presence: true

  # Associations
  belongs_to :user

  has_many :collaborations
  has_many :users, through: :collaborations

  has_many :assets
end
