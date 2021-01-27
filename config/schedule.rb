set :output, "./log/cron_log.log"
job_type :command,  "cd :path && ':task' :output"

every :thursday, at: '2:00 am' do
  command "./task.sh"
end
