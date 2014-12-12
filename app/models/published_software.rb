class PublishedSoftware < ActiveRecord::Base

  attr_accessor :delete_icon
  has_attached_file :icon, :dependent => :destroy
  validates_attachment_content_type :icon, :content_type => /\Aimage\/.*\Z/
  before_validation { icon.clear if delete_icon == '1' }

  def to_s
    title
  end

  def repository_handler
    RepositoryHandler.new(repository_url: repository_url)
  end

  def load_repository_data
    blueprint = repository_handler.load_blueprint_from_repository
    self.website_from_repository = blueprint['software']['home_page']
    self.name_from_repository = blueprint['software']['name']
    self.description_from_repository = blueprint['software']['description']
    self.icon_url_from_repository = blueprint['software']['icon_url']
  end

  def update_icon_from_url_in_respository
    self.icon = icon_from_url icon_url_from_repository
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