require "test_helper"

class ReadingsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @id = '36d5658a-6908-479e-887e-a949ec199272'
    @reading = Reading.create(
      id: @id,
      timestamp: "2021-09-29T16:08:15+01:00",
      count: 2
    )
  end
  
  test 'create with invalid params' do
    post readings_url, params: { id: @id, readings: [] }
    assert_response :unprocessable_entity
  end

  test 'create with valid params' do
    post readings_url, params: {
      id: @id,
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
    get reading_url(id: @id)
    assert_response :success
  end

  test 'show count' do
    get count_reading_url(id: @id)
    assert_response :success
  end
end
