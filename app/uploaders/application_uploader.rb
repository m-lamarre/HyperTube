class ApplicationUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  # storage :dropbox

  def store_dir
    [
      'hypertube',
      (Rails.env.production? ? 'assets' : Rails.env),
      model.class.to_s.underscore.dasherize,
      mounted_as.to_s.dasherize,
      model.id
    ].compact.join('/')
  end

  def default_url
    image_path = [
      mounted_as.to_s.dasherize,
      "#{version_name.to_s.dasherize}.jpg",
    ].compact.join('-')
    ActionController::Base.helpers.asset_path(['assets', 'images', 'fallbacks', image_path].join('/'))
  end

end
