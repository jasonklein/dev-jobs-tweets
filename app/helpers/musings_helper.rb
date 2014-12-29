module MusingsHelper

  def musing_company_url(company_name)
    company_slug = company_name.downcase.gsub(/[^0-9a-z]/i, '')
    company_url = "https://www.themuse.com/companies/" + company_slug
    link_to company_name, company_url, class: "special-link", target: "blank"
  end

  def musing_hiring_statement(musing)
    "#{musing.company_name} is hiring for: #{musing.title}."
  end

  def musing_archive_hiring_statement(musing)
    raw "#{musing_company_url(musing.company_name)} is hiring for: #{musing.title}. #{musing_apply_link_statement(musing.apply_link)}"
  end

  def musing_apply_link_statement(apply_link)
    encouragements = ["Apply!", "Apply today!", "Check it out!"]
    encouragement = encouragements.sample
    link_to encouragement, apply_link, class: "special-link", target: "blank"
  end

end