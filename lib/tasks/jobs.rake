namespace :jobs do

  desc 'run tasks on heroku'
  task :work do
    Rake::Task['cleanup:delete_old_movies'].invoke
    Rake::Task['cleanup:cleanup_putio'].invoke
  end
end
