# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  favorite    :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  private     :boolean          default(FALSE)
#  user_id     :integer
#

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
