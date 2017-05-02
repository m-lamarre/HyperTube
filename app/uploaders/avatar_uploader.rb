class AvatarUploader < ApplicationUploader

  version(:avatar) { process resize_to_fill: [200, 200] }

  def extension_white_list
    %w/jpg jpeg png svg/
  end

end
