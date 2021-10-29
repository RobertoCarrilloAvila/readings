require 'csv'

module CsvDatabase

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def create(args)
      obj = new(args)
      CSV.open(csv_file_path, "a") do |csv|
        csv << obj.to_a
      end
      obj
    end

    def all
      CSV.read(csv_file_path).map { |row| parse_obj(row) }
    end
  
    def find(id)
      row = all.select { |row| row.id == id }.first
    end
  
    def where(column, value)
      raise ArgumentError.new 'Unknown column' unless @@csv_attr.include?(column)
      all.select { |row| row.send(column) == value }
    end
  
    def delete_all
      File.delete(csv_file_path) if File.exist?(csv_file_path)
      set_if_not_exists
    end

    def attr
      @@csv_attr
    end

    private

    def parse_obj(row)
      new(attr.zip(row[0...attr.length]).to_h)
    end
  
    def csv_attr(*attr)
      attr.map!(&:to_sym)
      attr_accessor(*attr)
      @@csv_attr = attr.freeze
    end
  
    def csv_file_path
      Rails.root.join('storage', "#{self.name.underscore}.csv").to_s
    end
  
    def set_if_not_exists
      File.open(csv_file_path, 'w') unless File.exist?(csv_file_path)
    end
  end



  def initialize(args = {})
    raise 'ArgumentError' unless args.is_a?(Hash)
    self.class.send(:set_if_not_exists)
    set_attr(args.transform_keys(&:to_sym))
  end

  def to_a
    self.class.attr.map { |attr| instance_variable_get("@#{attr}") }
  end

  private

  def set_attr(args)
    args.slice(*self.class.attr).each do |attr, val|
      instance_variable_set("@#{attr}", val)
    end
  end
end