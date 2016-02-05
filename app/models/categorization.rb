class Categorization < ActiveRecord::Base
  belongs_to :project
  belongs_to :asset
end
