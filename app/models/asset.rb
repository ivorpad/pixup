class Asset < ActiveRecord::Base
  belongs_to :project, foreign_key: 'project_id'
  belongs_to :user
end
