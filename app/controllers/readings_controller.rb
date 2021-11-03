class ReadingsController < ApplicationController

  before_action :validate_schema, only: [:create]

  def create
    id = params[:id]
    readings = params[:readings].each do |reading|
      read = Reading.new(id: id, timestamp: reading[:timestamp], count: reading[:count])
      Reading.create(read.as_json) unless Reading.exist?(read)
    end
    head :created
  end

  def show
    readings = Reading.where(:id, params[:id])
    render json: readings.sort_by { |reading| DateTime.iso8601(reading.timestamp) }.first
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
          minItems: 1,
          items: {
            type: 'object',
            properties: {
              timestamp: { type: 'string' },
              count: { type: ['integer', 'string'] }
            }
          }
        }
      }
    }
  end
end
