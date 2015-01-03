class Musing < ActiveRecord::Base
  attr_accessible :apply_link, :company_logo, :muse_created_at, :muse_id, :title, :for_juniors

  mount_uploader :company_logo, CompanyLogoUploader

  default_scope order('muse_created_at DESC')

end
