require_relative "individual"
class Population
  attr_accessor :individuals

  def initialize(genome_length,population_size,fitness_param,mutation_rate)
    @genome_length = genome_length
    @population_size = population_size
    @fitness_param = fitness_param
    @mutation_rate = mutation_rate
    set_individuals
    set_fitness
    sort_by_fitness
  end

  def set_individual
    Individual.new(@genome_length)
  end

  def set_individuals
    @individuals = (1..@population_size).map{|individual| set_individual}
  end

  def set_fitness
    @fitness_param 
    @individuals.each do |individual|
      individual.set_fitness(@fitness_param)
    end
    @individuals
  end

  def sort_by_fitness
    @individuals.sort_by!{ |individual| individual.fitness}.reverse!
  end

  def selection
    half_way_index = ((@individuals.size)/2).round
    @individuals.slice!(half_way_index,@individuals.size-1)
  end

  def consummate(male, female)
    dna_split = rand(@genome_length-1)+1
    father_dna = male.dna.slice(0,dna_split)
    mother_dna = female.dna.slice(dna_split,@genome_length)
    child = Individual.new(@genome_length)
    child.dna = father_dna+mother_dna
    return child
  end

  def reproduce
    current_individuals_size = @individuals.size
    current_individuals_size.times do |index|
      male = @individuals[index-1]
      female = @individuals[rand(@individuals.size)]
      @individuals<< consummate(male,female)
    end
    @individuals
  end

  def mutate
    @mutation_rate.times do
      individual=@individuals.sample
      individual.mutate
    end
    @individuals
  end

  def run_generation
    selection
    reproduce
    mutate
    set_fitness
    sort_by_fitness
    @individuals
  end

  def best_fit
     return[individuals[0].dna, individuals[0].fitness]
  end

  def record
    record = []
    individuals.each do |individual|
      record<<[individual.dna, individual.fitness]
    end
    return record
  end

end
