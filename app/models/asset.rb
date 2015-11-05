# == Schema Information
#
# Table name: assets
#
#  id         :integer          not null, primary key
#  title      :string
#  project_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Asset < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
end
