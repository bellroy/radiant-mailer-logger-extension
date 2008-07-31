namespace :radiant do
  namespace :extensions do
    namespace :mailer_logger do
      
      desc "Runs the migration of the Mailer Logger extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          MailerLoggerExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          MailerLoggerExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Mailer Logger to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[MailerLoggerExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(MailerLoggerExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
