require "bundler/setup"
Bundler.require(:default)
require "minitest/autorun"
require "minitest/pride"
require "base64"

class Minitest::Test
  private

  def teardown
    @tempfile = nil
  end

  def tempfile
    @tempfile ||= "#{tempdir}/#{Time.now.to_f}"
  end

  def tempdir
    @tempdir ||= File.dirname(Tempfile.new("tensorflow"))
  end
end
