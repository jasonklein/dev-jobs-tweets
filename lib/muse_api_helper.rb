module MuseApiHelper
  def base_url
    "https://www.themuse.com"
  end

  def initial_api_url
    "/api/v1/jobs?job_category%5B%5D=Engineering&job_level%5B%5D=Internship&job_level%5B%5D=Entry+Level&page=0&descending=true"
  end

  def initial_request_url
    base_url + initial_api_url
  end

  def get_musings
    response = HTTParty.get initial_request_url
    if response.code == 200
      page_count = response["page_count"]
      results = response["results"]
  end
end