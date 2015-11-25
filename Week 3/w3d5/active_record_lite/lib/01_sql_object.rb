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
    obj = DBConnection.execute(<<-SQL, id: id)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        id = :id
    SQL
    return nil if obj.empty?
    self.new(obj.first)
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
    self.class.columns.map { |column| self.send("#{column}") }
  end

  def insert
    col_names = self.class.columns.join(", ")
    question_marks = []
    self.class.columns.length.times { question_marks << "?" }
    DBConnection.execute(<<-SQL, attribute_values)
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks.join(", ")})
    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def update
    attr_names = self.class.columns.map { |attr_name| "#{attr_name} = ?"}.join(", ")
    DBConnection.execute(<<-SQL, attribute_values)
      UPDATE
        #{self.class.table_name}
      SET
        #{attr_names}
      WHERE
        id = #{attribute_values.first}
    SQL
  end

  def save
    attribute_values.first.nil? ? insert : update
  end
end
