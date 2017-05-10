namespace :cleanup do
  require "#{Rails.root}/app/controllers/concerns/putio"

  task :delete_old_movies do
    include Putio

    Putio.delete_old
    puts 'Deleted old movies.'
  end
end
