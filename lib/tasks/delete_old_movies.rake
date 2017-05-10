namespace :cleanup do
  require "#{Rails.root}/app/controllers/concerns/putio"

  desc 'Deleting old movies on the Putio server'
  task :delete_old_movies do
    include Putio

    puts Putio.delete_old
  end

  desc 'Managing storage space on the Putio server'
  task :cleanup_putio do
    include Putio

    puts Putio.cleanup
  end
end
