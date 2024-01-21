require 'csv'

namespace :hexlet do
  desc "Imports users from test/fixtures/files/users.csv"
  task :import_users, [:file_path] => :environment do |t, args|
    file_path = args[:file_path]

    if file_path.nil?
      puts "Usage: rails hexlet:import_users[file_path]"
      exit
    end

    print "Loading users from #{file_path}...\n"
    CSV.foreach(file_path, headers: :first_row) do |row|
      birthday = Date.strptime(row['birthday'], '%m/%d/%Y')

      User.create(first_name: row['first_name'],
                  last_name: row['last_name'],
                  birthday: birthday,
                  email: row['email'])
    end
    #User.find(2).update(name: first_name)
    print "...done!"
  end

end
