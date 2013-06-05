require 'csv'
require "net/https"
require "uri"

# Timestamp
# Student Name
# Email-Address
# Where do you plan to live?
# Please give a summary of your skills
# Is there a project you want to join?
# What project(s) are you planning to work on?
# About your pair
# Have you ever attended a Rails/Ruby Workshop?
# What level of coding do you see yourself in Ruby/Rails?
# What level of coding does your pair have?
# Please summarize what you've been doing to learn programming since your first workshop
# For how many months have you actively been learning after your first workshop?
# For how many months has your pair actively been learning after her first workshop?
# Do you have a Github Account or examples of your coding?
# Coach(es): Who is going to coach you?
# "Coach(es): How much time can your coaches put into (being available for) support in total?"
# Coach(es): Why do you think this team is going to be successfully working on their projects?
# When do you plan to work on this?
# Student E-mail Address
# About you
# "Where you live, how much money do you need at the very minimum per month to sustain yourself while working fulltime on an open source project?"

class ApplicationsImporter
  class << self
    def run(model, data)
      new(model, data).run
    end
  end

  attr_reader :model, :headers, :data

  def initialize(model, csv)
    @model = model
    @data = CSV.parse(csv)
    @headers = data.shift
  end

  def run
    data.each do |row|
      next unless row.first
      record = find(row)
      record ? update(record, row) : create(row)
    end
  end

  private

    def find(row)
      model.where(timestamp: row.first).first
    end

    def create(row)
      model.create!(attributes(row))
    end

    def update(record, row)
      record.update_attributes!(attributes(row))
    end

    def attributes(row)
      { timestamp: row[0], data: Hash[*headers.zip(row).flatten] }
    end
end
