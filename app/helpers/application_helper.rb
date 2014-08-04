module ApplicationHelper
  def display_path_with_protocol_and_host(path)
    "http://" + request.host + path
  end
end
