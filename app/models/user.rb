class User < ActiveRecord::Base
  enum role: [:member, :contributor, :admin]
  before_create :set_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable #:confirmable

  # Validations
  validates :name, presence: true

  # Associations
  has_many :collaborations
  has_many :projects, through: :collaborations
  has_many :created_projects, class_name: "Project"
  has_many :assets, dependent: :destroy
  has_many :comments, dependent: :destroy

  def admin?
    role == "admin"
  end

  def member?
    role == "member"
  end

  def contributor?
    role == "contributor"
  end

  private

  def set_default_role
    self.role ||= :member
  end

  def password_required?
    new_record? ? false : super
  end

end
