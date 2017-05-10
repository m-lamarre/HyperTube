namespace :cleanup do
  require "#{Rails.root}/app/controllers/concerns/putio"

  task :delete_old_movies do
    include Putio

    puts Putio.delete_old
  end

  task :cleanup_putio do
    include Putio

    puts Putio.cleanup
  end
end
