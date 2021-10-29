require "test_helper"

class ReadingsControllerTest < ActionDispatch::IntegrationTest
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

  test 'create with invalid params' do
    post readings_url, params: {
      id: "36d5658a-6908-479e-887e-a949ec199272",
      readings: []
    }
    assert_response :unprocessable_entity
  end

  test 'show' do
    get reading_url(id: "36d5658a-6908-479e-887e-a949ec199272")
    assert_response :success
  end

  test 'show count' do
    get count_reading_url(id: "36d5658a-6908-479e-887e-a949ec199272")
    assert_response :success
  end
end
