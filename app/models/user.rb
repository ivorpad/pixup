class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Validations
  validates :name, presence: true

  # Associations
  has_many :collaborations
  has_many :projects, through: :collaborations
  has_many :created_projects, class_name: "Project"
  has_many :assets, dependent: :destroy
end
