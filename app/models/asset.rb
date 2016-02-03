class Asset < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  mount_uploader :asset_file, AssetItemUploader

  validates_presence_of :title, :category

  belongs_to :project
  belongs_to :user
  belongs_to :category

  has_many :comments, dependent: :destroy

  def self.assets_fetcher_for(project, category)
    Asset.where(:project_id => project.id, :category_id => category.id)
  end

  def slug_candidates
   [
     :title,
     [:title, :title_sequence]
   ]
  end

  def title_sequence
   slug = normalize_friendly_id(title)
   sequence = Asset.where("slug like '#{slug}-%'").count + 2
  end
end
