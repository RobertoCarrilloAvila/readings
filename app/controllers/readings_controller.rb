class ReadingsController < ApplicationController

  before_action :validate_schema, only: [:create]

  def create
    id = params[:id]
    readings = params[:readings].each do |reading|
      Reading.create(id: id, timestamp: reading[:timestamp], count: reading[:count])
    end
    head :created
  end

  def show
    render json: Reading.find(params[:id])
  end

  def count
    @readings = Reading.where(:id, params[:id])
    render json: { cumulative: @readings.inject(0) { |sum, reading| sum + reading.count.to_i } }
  end

  private

  def validate_schema
    json = params.slice(:id, :readings).as_json
    JSON::Validator.validate!(schema, json)
  rescue JSON::Schema::ValidationError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def schema
    {
      type: 'object',
      properties: {
        id: { type: 'string' },
        readings: {
          type: 'array',
          minItems: 2,
          items: {
            type: 'object',
            properties: {
              timestamp: { type: 'string' },
              count: { type: 'integer' }
            }
          }
        }
      }
    }
  end
end
