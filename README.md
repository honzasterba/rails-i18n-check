# rails-i18n-check

A simple checker for missing translations in rails i18n config files


require 'rails-i18n-checker'
namespace :i18n do
  task :check => :environment do
    RailsI18nCheck::Checker.new(%w[en cs], Rails.root).run
  end
end
