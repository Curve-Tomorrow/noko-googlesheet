require 'date'
namespace :import do

  task users: :environment do
    NokoService.import_users
  end

  task projects: :environment do
    NokoService.import_projects
  end


  desc "Import new Noko entries"
  task entries: [:users, :projects, :environment] do
    start_date = Date.today.prev_day
    end_date = Date.today

    puts "start importing entries from #{start_date} to #{end_date}"

    NokoService.import_entries(start_date, end_date)

    puts 'finished importing entries'
  end
end

namespace :export do

  desc "Export to Google entries"
  task gsheet: :environment do
    GoogleService.export_sample
  end
end

namespace :calc do
  desc "Calculate Leaderboards"
  task leaderboards: :environment do
    ProjectLeaderboard.calculate
    UserLeaderboard.calculate
  end
end
