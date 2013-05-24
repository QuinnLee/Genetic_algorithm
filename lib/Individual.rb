class Individual
  attr_accessor :dna
  attr_reader :fitness

  def initialize(genome_length)
    @genome_length = genome_length
    set_dna
  end

  def set_dna
   @dna = (1..@genome_length).map{|gene| rand(2)}
  end

  def set_fitness(fitness_param)
    @fitness = 0
    dna.each_with_index do |gene,index|
      @fitness +=1 if gene == fitness_param[index]
    end
    @fitness
  end

end