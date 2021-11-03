require "test_helper"

class ReadingsControllerTest < ActionDispatch::IntegrationTest
  def setup
    File.chmod(0755, Rails.root.join('storage'))
    Reading.delete_all
  end

  test 'create with invalid params' do
    post readings_url, params: {
      id: "36d5658a-6908-479e-887e-a949ec199272",
      readings: []
    }
    assert_response :unprocessable_entity
  end

  test 'create with valid params' do
    post readings_url, params: {
      id: "36d5658a-6908-479e-887e-a949ec199272",
      readings: [
        {
          timestamp: "2021-09-29T16:08:15+01:00",
          count: 2
        },
        {
          timestamp: "2021-09-29T16:09:15+01:00",
          count: 15
        }
      ]
    }
    assert_response :created
  end

  test 'show' do
    Reading.create(
      id: "36d5658a-6908-479e-887e-a949ec199272",
      timestamp: "2021-09-29T16:08:15+01:00",
      count: 2
    )
    get reading_url(id: "36d5658a-6908-479e-887e-a949ec199272")
    assert_response :success
  end

  test 'show count' do
    Reading.create(
      id: "36d5658a-6908-479e-887e-a949ec199272",
      timestamp: "2021-09-29T16:08:15+01:00",
      count: 2
    )
    get count_reading_url(id: "36d5658a-6908-479e-887e-a949ec199272")
    assert_response :success
  end

  test 'file a permission issue' do
    File.chmod(0000, Rails.root.join('storage'))
    assert_raise(Errno::EACCES) do
      Reading.create(
        id: "36d5658a-6908-479e-887e-a949ec199272",
        timestamp: "2021-09-29T16:08:15+01:00",
        count: 2
      )
    end
  end

  def teardown
    File.chmod(0755, Rails.root.join('storage'))
  end
end
