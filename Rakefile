# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

desc "Print out routes"
task routes: :environment do
  Mercury::API::V1::Base.routes.each do |route|
    info = route.instance_variable_get :@options
    description = format("%-40s...", info[:description][0..39])
    method = format("%-7s", info[:method])
    puts "#{description}  #{method}#{info[:path]}"
  end
end
