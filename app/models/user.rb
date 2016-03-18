class User < ActiveRecord::Base
  rolify
  mount_uploader :avatar, AvatarUploader

  after_create :assign_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable #:confirmable

  # Validations
  validates :name, presence: true

  # Associations
  has_many :collaborations
  has_many :project_collaborations, through: :collaborations, source: :project
  has_many :created_projects, :class_name => "Project"

  has_many :projects

  has_many :assets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :posts, dependent: :destroy

  def likes?(asset)
    asset.likes.where(user_id: id).any?
  end

  def collaborator_of?(project)
    all_projects.include?(project)
  end

  def all_projects
    created_projects + project_collaborations
  end

  private

  def password_required?
    new_record? ? false : super
  end

  def assign_default_role
    add_role :member
  end
end
