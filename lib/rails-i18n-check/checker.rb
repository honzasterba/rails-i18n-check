require 'yaml'
require 'pathname'

class RailsI18nCheck::Checker

  def initialize(locales, root, ignored_keys=[], raise_on_missing=true)
    @locales = locales
    @root = root
    @ignored_keys = ignored_keys
    @raise_on_missing = raise_on_missing
  end

  def run
    locales_dir = File.join(@root, "config/locales");
    locale_files = Dir.glob(File.join(locales_dir, "**/*.yml"))
    all_keys = load_all_keys(locale_files)
    missing_keys = @locales.map do |locale|
      locale_data = load_locale locale_files, locale
      find_missing all_keys, locale, locale_data
    end
    missing_keys.flatten!.reject! &:nil?
    if @raise_on_missing && missing_keys.any?
      raise "Some translations are missing."
    else
      missing_keys
    end
  end

  def find_missing(all_keys, locale, locale_data)
    puts "Keys missing in #{locale}"
    find_missing_in_hash all_keys, locale_data[locale], ""
  end

  def find_missing_in_hash(registry, local, path)
    registry.map do |key, val|
      if local[key].nil?
        if @ignored_keys.member? key
          []
        else
          info = missing_info val
          res = "#{path}.#{key} #{info}"
          puts res
          [res]
        end
      elsif val.is_a? Hash
        find_missing_in_hash val, local[key], "#{path}.#{key}"
      end
    end
  end

  def missing_info(value)
    if value.is_a?(Hash)
      value.each do |_, val|
        return missing_info val
      end
    else
      value
    end
  end

  def load_locale(files, locale)
    files.inject({}) do |data, file|
      file_data = YAML.load_file(file)
      if file_data[locale]
        merge data, file_data
      else
        data
      end
    end
  end

  def load_all_keys(files)
    files.inject({}) do |data, file|
      file_data = YAML.load_file(file)
      file_locale = file_data.keys.first
      merge_keys data, file_data[file_locale], Pathname.new(file).basename.to_s
    end
  end

  def merge_keys(into, data, file)
    return {} unless data
    data.each do |key, value|
      if into[key] && into[key].is_a?(Hash)
        merge_keys into[key], value, file
      elsif value.is_a? Hash
        into[key] = {}
        merge_keys into[key], value, file
      else
        into[key] ||= []
        into[key] << file
      end
    end
    into
  end

  def merge(into, data)
    data.each do |key, value|
      if into[key] && into[key].is_a?(Hash)
        merge into[key], value
      else
        into[key] = value
      end
    end
    into
  end

end
