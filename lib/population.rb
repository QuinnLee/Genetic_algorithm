class Population
  attr_reader :species

  def initialize(genome_length,population_size,fitness_param,mutation_rate)
    @genome_length = genome_length
    @population_size = population_size
    @fitness_param = fitness_param
    @mutation_rate = mutation_rate
    set_species
    set_fitness
    sort_by_fitness
  end

  def set_individual
    Individual.new(@genome_length)
  end

  def set_species
    @species = (1..@population_size).map{|individual| set_individual}
  end

  def set_fitness
    @fitness_param 
    @species.each do |individual|
      individual.set_fitness(@fitness_param)
    end
    @species
  end

  def sort_by_fitness
    @species.sort_by!{ |individual| individual.fitness}.reverse!
  end

  def selection
    half_way_index = ((@species.size)/2).round
    @species.slice!(half_way_index,@species.size-1)
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
    current_species_size = @species.size
    current_species_size.times do |index|
      male = @species[index-1]
      female = @species[rand(@species.size)]
      @species<< consummate(male,female)
    end
    @species
  end

  def mutate
    @mutation_rate.times do
      individual=@species.sample
      individual.mutate
    end
    @species
  end

  def run_generation
    selection
    reproduce
    mutate
    set_fitness
    sort_by_fitness
    @species
  end

end
