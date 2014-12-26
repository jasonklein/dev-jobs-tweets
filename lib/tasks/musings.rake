require_relative '../muse_api_helper'
include MuseApiHelper

namespace :musings do
  desc "Get job posts from The Muse"
  task :get => :environment do
    get_musings
  end

  desc "Destroy old musings"
  task :destroy_old_musings => :environment do
    musings = Musing.where("muse_created_at < ?", 3.months.ago)
    musings.destroy_all
  end
end