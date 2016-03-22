class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  belongs_to :category

  has_many :comments, as: :commentable, dependent: :destroy
end
