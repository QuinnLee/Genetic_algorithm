require_relative "population"
require "pry"
class Input
  attr_accessor :population, :best_fit, :record
  attr_reader :genome_length, :population_size, :fitness_param, :mutation_rate, :generation_count

  def initialize(genome_length, population_size, fitness_param, generation_count)
    set_genome_length (genome_length)
    set_population_size (population_size)
    set_fitness_param(fitness_param)
    set_generation_count(generation_count)
    set_mutation_rate
    @population = Population.new(@genome_length,@population_size,@fitness_param,@mutation_rate)
  end

  def set_genome_length (genome_length)
    @genome_length = 20 if genome_length <2 or genome_length == nil
    @genome_length = genome_length if genome_length >=2
    puts "Genome length is #{@genome_length} bits long"
    @genome_length
  end

  def set_mutation_rate
    @mutation_rate = (@population_size/20).round
  end


  def set_population_size (population_size)
    @population_size = 20 if population_size < 2 or population_size == nil
    @population_size = population_size if population_size >=2
    puts "Population size is #{@population_size} individual"
    @population_size
  end

  def set_fitness_param(fitness_param)
    if check_for_array(fitness_param) && check_for_validity(fitness_param) && check_for_length(fitness_param)
      @fitness_param = fitness_param
    else
      @fitness_param = (1..genome_length).map{|gene| rand(2)}
    end
    puts "Fitness Parameter is #{@fitness_param}"
    @fitness_param 
  end
  
  def check_for_array(fitness_param)
    return true if fitness_param.class == Array
    return false if fitness_param.class != Array
  end

  def check_for_validity(fitness_param)
    fitness_param.each do |gene|
      return false if [1,0].include?(gene)==false
    end
    true
  end

  def check_for_length(fitness_param)
    return false if fitness_param.length != @genome_length
    return true if fitness_param.length == @genome_length
  end

  def set_generation_count(generation_count)
    @generation_count = 20 if generation_count <= 0 || generation_count.class != Fixnum
    @generation_count = generation_count if generation_count > 1
    @generation_count
  end

  def storage
    @best_fit = {}
    @record = {}
  end

  def run
    storage
    @best_fit[0] = population.best_fit
    @record[0] = population.record
    @generation_count.times do |year|
      population.run_generation
      @best_fit[year] = population.best_fit
      @record[year] = population.record
    end
  end
end

