# == Schema Information
#
# Table name: categorizations
#
#  id          :integer          not null, primary key
#  project_id  :integer
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Categorization < ActiveRecord::Base
  belongs_to :project
  belongs_to :category
end
