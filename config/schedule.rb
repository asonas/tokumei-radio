set :output, "./log/cron_log.log"
job_type :command,  "cd :path && ':task' :output"

every :thursday, at: '1:05 am' do
  command "./task.sh"
end
