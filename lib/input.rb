class Input
  attr_accessor :population
  attr_reader :genome_length, :population_size, :fitness_param, :mutation_rate, :generation_count

  def initialize(genome_length, population_size, fitness_param, mutation_rate)
    set_genome_length (genome_length)
    set_population_size (population_size)
    set_fitness_param(fitness_param)
    @population = Population.new(genome_length,population_size,fitness_param,mutation_rate)
  end

  def set_genome_length (genome_length)
    @genome_length = 20 if genome_length <2 or genome_length == nil
    @genome_length = genome_length if genome_length >=2
    @genome_length
    # puts "Genome length is #{@genome_length} bits long"
  end

  def set_population_size (population_size)
    @population_size = 20 if population_size < 2 or population_size == nil
    @population_size = population_size if population_size >=2
    @population_size
    # puts "Population size is #{@population_size} individual"
  end

  def set_fitness_param(fitness_param)
    if check_for_array(fitness_param) && check_for_validity(fitness_param) && check_for_length(fitness_param)
      @fitness_param = fitness_param
    else
      @fitness_param = (1..genome_length).map{|gene| rand(2)}
    end
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
end