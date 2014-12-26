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

  def extended_request_url(page_number)
    @extended_api_url = page_number == 1 ? initial_api_url : @extended_api_url
    @extended_api_url = @extended_api_url || initial_api_url
    @extended_api_url = @extended_api_url.gsub "page=#{page_number - 1}", "page=#{page_number}"
    base_url + @extended_api_url
  end

  def get_musings
    response = HTTParty.get initial_request_url
    if response.code == 200
      page_count = response["page_count"]
      results = response["results"]
      # i = 1
      # while i < page_count
      #   extended_response = HTTParty.get extended_request_url(i)
      #   if extended_response.code == 200
      #     results = results + extended_response["results"]
      #   end
      #   i += 1
      # end
    end
    filtered_results = filter_musings results
    save_musings filtered_results
  end

  def is_irrelevant?(title)
    title = title.downcase
    filter_terms = %W(software dev back front end javascript ios mobile android junior jr web ruby rails)
    ### Returns false if the filter terms ARE included in the result's title
    !filter_terms.any? { |term| title.include? term }
  end

  def is_old?(creation_date)
    creation_date < 3.months.ago
  end

  def filter_musings(results)
    results.delete_if do |result|
      is_irrelevant?(result["title"]) || is_old?(result["creation_date"])
    end
    results
  end

  def save_musings(results)
    results.each do |result|
      Musing.where(muse_id: result["id"].to_s).first_or_create do |m|
        m.title = result["title"]
        m.apply_link = base_url + result["apply_link"]
        m.muse_created_at = result["update_date"]
        m.remote_company_logo_url = result["company_small_logo_image"]
      end
    end
  end
end