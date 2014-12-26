class Musing < ActiveRecord::Base
  attr_accessible :apply_link, :company_logo, :muse_created_at, :muse_id, :title

  mount_uploader :company_logo, CompanyLogoUploader
end
