require 'minitest/hooks/test'

class CsvDatabaseTest < Minitest::Test
  include Minitest::Hooks

  def test_file_permission_issue
    File.chmod(0000, Rails.root.join('storage'))
    assert_raises(Errno::EACCES) do
      Reading.create(
        id: @id,
        timestamp: "2021-09-29T16:08:15+01:00",
        count: 2
      )
    end
  end

  def after_all
    File.chmod(0755, Rails.root.join('storage'))
  end
end