class PublishedSoftware < ActiveRecord::Base

  attr_accessor :delete_icon
  has_attached_file :icon, :dependent => :destroy
  validates_attachment_content_type :icon, :content_type => /\Aimage\/.*\Z/
  before_validation { icon.clear if delete_icon == '1' }

  acts_as_commentable

  validates :title, :presence => true
  validates :repository_url, :presence => true

  def to_label
    title
  end

  def repository_handler
    RepositoryHandler.new(repository_url: repository_url)
  end

  def load_repository_data
    blueprint = repository_handler.load_blueprint_from_repository
    if blueprint
      self.website_from_repository = blueprint['software']['home_page']
      self.name_from_repository = blueprint['software']['name']
      self.description_from_repository = blueprint['software']['description']
      self.icon_url_from_repository = blueprint['software']['icon_url']
      return true
    end
  rescue
    return false
  end

  def update_icon_from_url_in_respository
    if icon_url_from_repository.present?
      self.icon = icon_from_url icon_url_from_repository
    end
  end

  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      where(nil)
    end
  end

private

  def icon_from_url url
    begin
      begin
        URI.parse(url)
      rescue Exception=>e
        nil
      end
    rescue
      nil
    end
  end

end