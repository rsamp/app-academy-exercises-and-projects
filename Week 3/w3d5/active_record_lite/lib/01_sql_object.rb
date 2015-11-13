require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    all_data = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL
    all_data.first.map! {|key| key.to_sym}
  end

  def self.finalize!
    columns.each do |column|
      define_method "#{column}" do
        attributes[column]
      end

      define_method "#{column}=" do |attribute|
        attributes[column] = attribute
      end
    end
  end

  def self.table_name=(table_name)
    instance_variable_set("@#{name}", table_name)
  end

  def self.table_name
    instance_variable_get("@#{name}") ||
      instance_variable_set("@#{name}", self.to_s.tableize)
  end

  def self.all
    cats = DBConnection.execute(<<-SQL)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
    SQL
    parse_all(cats)
  end

  def self.parse_all(results)
    cats = []
    results.each do |result|
      cats << self.new(result)
    end
    cats
  end

  def self.find(id)
    cat = DBConnection.execute(<<-SQL, id: id)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        id = :id
    SQL
    nil if cat.length == 0
    cat.first
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      attr_name = attr_name.to_sym
      raise "unknown attribute '#{attr_name}'" unless self.class.columns.include?(attr_name)
      self.send("#{attr_name}=", value)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end


# DBConnection.execute(<<-SQL, table: self, column: column, attribute: attribute)
#   INSERT INTO
#     :table (:column)
#   VALUES
#     :attribute
# SQL
