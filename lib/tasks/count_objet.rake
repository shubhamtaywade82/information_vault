# group your task in a namespace, thus avoiding any conflict if task with same name already exists.
namespace :custom do
  #: https://guides.rubyonrails.org/v4.2/command_line.html#custom-rake-tasks
  # Desctiption of the Task can be deleted
  desc 'print total number of objects of any primary model of the application'
  # Task contains the code to perdoem the action of counting the number of object in the Model
  # :count_records : Name of the task as a symbol
  # arguments: [:model] =
  task :count_records, [:model] => :environment do |t, args|
    puts "Number of objects in #{args.model} = #{Object.const_get(args.model).count}"
  end

  # run as rake custom:count_records[<ModelName>]
end

