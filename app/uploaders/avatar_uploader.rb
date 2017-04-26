class AvatarUploader < ApplicationUploader

  google_login ENV['gmail_username']
  google_password ENV['gmail_password']

  version(:avatar) { process resize_to_fill: [200, 200] }

  def extension_white_list
    %w/jpg jpeg png/
  end

end
