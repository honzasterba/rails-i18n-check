require 'test_helper'

class CheckerTest < Minitest::Test

  def setup
    @files_dir = File.expand_path('../files', __FILE__)
  end

  def run_checker(dir, ignore=[])
    RailsI18nCheck::Checker.new(
      %w[en cs],
      "#{@files_dir}/#{dir}", ignore, false
    ).run
  end

  def test_all_good
    res = RailsI18nCheck::Checker.new(%w[en cs], "#{@files_dir}/all_good").run
    assert_equal [], res
  end

  def test_raises_file
    assert_raises "Some translations are missing." do
      RailsI18nCheck::Checker.new(%w[en cs], "#{@files_dir}/missing_single_file").run
    end
  end

  def test_single_file
    res = run_checker("missing_single_file")
    assert_equal ['.sub1.key3 ["cs.yml"]', '.key2 ["en.yml"]'], res
  end


  def test_multi_file
    res = run_checker("missing_multi_file")
    expected = [
      '.sub1.key3 ["cs.yml"]',
      '.sub.sub1.key3 ["cs.sub.yml"]',
      '.sub.key2 ["en.sub.yml"]',
      '.key2 ["en.yml"]'
    ]
    assert_equal expected, res
  end

  def test_multi_file_ignore
    res = run_checker("missing_multi_file", ["key3"])
    expected = [
      '.sub.key2 ["en.sub.yml"]',
      '.key2 ["en.yml"]'
    ]
    assert_equal expected, res
  end

end
