class User < ActiveRecord::Base
  after_create { |admin| admin.send_reset_password_instructions }
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

  belongs_to :role

  def admin?
    self.role == "admin"
  end

  def member?
    self.role == "member"
  end

  def banned?
    self.role == "banned"
  end

  private

  def password_required?
    new_record? ? false : super
  end

  def set_default_role
    self.role ||= Role.find_by_name('member')
  end
end
