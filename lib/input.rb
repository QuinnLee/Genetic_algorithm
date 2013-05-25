class Input
  attr_reader :genome_length, :population_size

  def initialize(genome_length, population_size, fitness_param, mutation_rate)
    set_genome_length (genome_length)
    set_population_size (population_size)
    set_fitness_param(fitness_param)
  end

  def set_genome_length (genome_length)
    @genome_length = 20 if genome_length <2 or genome_length == nil
    @genome_length = genome_length if genome_length >=2
    # puts "Genome length is #{@genome_length} bits long"
  end

  def set_population_size (population_size)
    @population_size = 20 if population_size < 2 or population_size == nil
    @population_size = population_size if population_size >=2
    # puts "Population size is #{@population_size} individual"
  end

  def set_fitness_param(fitness_param)
    if fitness_param.class != Array
      @fitness_param = (1..genome_length).map{|gene| rand(2)}
    end
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
end