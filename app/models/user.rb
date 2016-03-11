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
  has_many :projects, through: :collaborations

  has_many :assets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :posts, dependent: :destroy

  def likes?(asset)
    asset.likes.where(user_id: id).any?
  end

  def collaborator_of?(project)
    project.collaborators.exists?(self.id)
  end

  def current_projects
    Project.joins(:users).where("projects.user_id = ?", self.id)
  end

  private

  def password_required?
    new_record? ? false : super
  end

  def assign_default_role
    add_role :member
  end
end
