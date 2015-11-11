# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :projects, through: :categorizations
  has_many :assets, through: :categorizations, source: 'asset'
end