# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
set :output, {:error=>'log/error.log', :standard=>'log/cron.log'}
#
every '30 21 * * *' do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
    runner 'Progre.check_dropout(User.all, HackTag.all); Rails.logger.flush'
    runner 'UsersHacktag.update_from_progres(Progre.all); Rails.logger.flush'
    runner 'HackTag.check_exit(HackTag.all); Rails.logger.flush'
    runner 'HackTagFollow.check_exit; Rails.logger.flush'
#   rake "some:great:rake:task"
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
