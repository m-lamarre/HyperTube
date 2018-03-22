module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'HyperTube'
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

  def oauth_link_name provider
    if provider == :marvin
      '42'
    elsif provider == :google_oauth2
      'Google'
    else
      provider
    end
  end
end
