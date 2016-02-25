class User < ActiveRecord::Base
  rolify

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
  has_many :comments, dependent: :destroy
  has_many :likes

  def likes?(asset)
    asset.likes.where(user_id: id).any?
  end

  private

  def password_required?
    new_record? ? false : super
  end

  def assign_default_role
    add_role :member
  end
end
