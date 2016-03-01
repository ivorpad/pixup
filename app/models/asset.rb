class Asset < ActiveRecord::Base

  # External Gems
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]
  mount_uploader :asset_file, AssetItemUploader


  # Validations
  validates_presence_of :title, :category

  # Associations
  belongs_to :project
  belongs_to :user
  belongs_to :category


  has_many :likes

  # Public Methods

  def self.assets_fetcher_for(project, category)
    Asset.where(project_id: project.id, category_id: category.id)
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

  def should_generate_new_friendly_id?
   title_changed?
  end

  def upload_mime_type?(type)
    asset_hash = {
                  image: %r{^image\/(jpg|png|gif|jpeg)},
                  application: %r{^application\/(pdf)},
                  video: %r{^video\/(quicktime|mpeg)},
                  audio: %r{^audio\/(mpeg3|x-mpeg-3|mpeg|x-mpeg)}
                }

    self.asset_file.file.content_type.match(asset_hash[type])
  end


end
