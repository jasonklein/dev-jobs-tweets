module ApplicationHelper
  def display_path_with_protocol_and_host(path)
    "http://" + request.host + path
  end

  def in_production?
    Rails.env.production?
  end
end
