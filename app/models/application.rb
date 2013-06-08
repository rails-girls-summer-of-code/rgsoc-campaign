class Application < ActiveRecord::Base
  class << self
    def sort_by(column)
      column.to_sym == :id ? order(column) : all.sort_by(&column.to_sym)
    end
  end

  attr_accessible :timestamp, :data

  serialize :data

  has_many :ratings, order: :user_name
  has_many :comments

  def prev
    self.class.where('id < ?', id).order(:id).first
  end

  def next
    self.class.where('id > ?', id).order(:id).first
  end

  def student_name
    data.values[1]
  end

  def total_rating
    values = ratings.map(&:value)
    total = values.length > 0 ? (values.sum / values.length).round(2) : 0
    total += SPONSOR_PICK if sponsor_pick?
    total
  end

  def rating_defaults
    keys = [:women_priority, :skill_level, :practice_time, :project_time, :support]
    keys.inject({}) { |defaults, key| defaults.merge(key => send("estimated_#{key}")) }
  end

  SPONSOR_PICKS = { github: 9, soundcloud: 55 }

  def sponsor_pick?
    SPONSOR_PICKS.values.include?(id)
  end

  def estimated_women_priority
    5 + (seems_to_have_pair? ? 5 : 0)
  end

  def estimated_skill_level
    if seems_to_have_pair?
      values = [student_skill_level, pair_skill_level].sort
      ((values.first.to_f + values.last.to_f * 2) / 3).round
    else
    end
  end

  def estimated_practice_time
    if seems_to_have_pair?
      [student_practice_time.to_i, pair_practice_time.to_i].max
    else
      student_practice_time
    end
  end

  def estimated_project_time
    10
  end

  def estimated_support
    value = data['Coach(es): How much time can your coaches put into (being available for) support, in total?']
    return unless value =~ /^\d+$/
    value = value.to_i
    case true
      when value >= 5 then 8
      when value >= 3 then 5
      when value >= 1 then 1
    end
  end

  def seems_to_have_pair?
    !!pair_skill_level
  end

  def student_skill_level
    data['What level of coding do you see yourself in Ruby/Rails?'].try(:to_i)
  end

  def pair_skill_level
    data['What level of coding does your pair have?'].try(:to_i)
  end

  PRACTICE_TIME = {
    'Between 1 and 3 months'  => 2,
    'Between 3 and 6 months'  => 4,
    'Between 6 and 9 months'  => 6,
    'Between 9 and 12 months' => 8,
    'More that 12 months'     => 10
  }

  def student_practice_time
    PRACTICE_TIME[data['For how many months have you actively been learning after your first workshop?']]
  end

  def pair_practice_time
    PRACTICE_TIME[data['For how many months has your pair actively been learning after her first workshop?']]
  end

  # def filtered_data
  #   data.dup.delete_if { |key, value| key =~ /Student/ }
  # end
end
