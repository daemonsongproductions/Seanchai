namespace :db do
  desc "Load seed fixtures (from db/fixtures) into the current environment's database."
  task :seed => :environment do
    require 'active_record/fixtures'
    Dir.glob(::Rails.root.to_s + '/db/fixtures/*.yml').each do |file|
      Fixtures.create_fixtures('db/fixtures', File.basename(file, '.*'))
    end
  end
end