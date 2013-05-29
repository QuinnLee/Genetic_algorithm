require "spec_helper"

describe Population do
  let (:genome_length){10}
  let (:population_size){10}
  let (:mutation_rate){3}
  let (:population){Population.new(genome_length,population_size,fitness_param,mutation_rate)}
  let (:fitness_param){(1..genome_length).map{|gene| rand(2)}}

  describe "#make_individual" do
    let (:individual){population.set_individual}
    it "makes individual" do
      expect(individual).to be_an_instance_of(Individual)
    end
  end

  describe "#set_individuals" do
    let(:individuals){population.set_individuals}
    it " is an array of individuals"do
      expect(individuals).to be_an_instance_of(Array)
      individuals.each do |individual|
        expect(individual).to be_an_instance_of(Individual)
        expect(individual.dna).to_not be_nil
      end
    end
  end

  describe "#set_fitness" do
    let(:individuals) do 
      population.set_individuals 
      population.set_fitness 
    end

    it "sets a fitness level for individuals" do
      individuals.each do |individual|
        expect(individual.fitness).to be > 0
      end
    end
  end

  describe "#sort_by_fitness" do
    let(:fitness_param){(1..genome_length).map{|gene| rand(2)}}
    let(:individuals) do 
      population.set_individuals 
      population.set_fitness
      population.sort_by_fitness
    end

    it "the first individual has the highest fitness" do
      previous = individuals[0]
      individuals.each do |individual|
        expect(individual.fitness).to be <= (previous.fitness)
        previous = individual
      end
    end
  end

  describe "#selection" do
    let (:new_population_size){(population_size/2).round}
    let (:new_individuals) do 
      population.set_individuals 
      population.set_fitness
      population.sort_by_fitness
      population.selection
    end
    it "remove least fit half of the individuals" do
      expect(new_individuals.size).to eql(new_population_size)
    end
  end

  describe "#consummate" do 
    let (:male){Individual.new(genome_length)}
    let (:female){Individual.new(genome_length)}
    let (:child){population.consummate(male,female)}
    it "creates a new individual from 2 individuals" do
      expect(child).to be_an_instance_of(Individual)
    end
    it "creates a child with dna" do
      expect(child.dna).to be_an_instance_of(Array)
      expect(child.dna).to_not be_nil
      expect(child.dna.length).to eql(genome_length)
    end
  end

  describe "#reproduce" do
    let(:individuals){population.reproduce}
    it "increases the population by 100%" do
      expect(individuals.size).to eql(population_size*2)
      individuals.each do |individual|
        expect(individual).to be_an_instance_of(Individual)
      end
    end
  end

  describe "#mutate" do

    let(:old_dna_set) do
      population.individuals.map do |dna|
        dna.dup
      end
    end

    let(:new_dna_set) do
      population.mutate
      population.individuals.map do |dna|
        dna.dup
      end
    end

    it "randomly changes the genes of individuals"do
      expect(new_dna_set).to_not eql(old_dna_set)
    end  
  end

  describe "#best_fit" do
    it "returns a array of the top dna with fitness" do
      expect(population.best_fit).to be_an_instance_of(Array)
    end
  end

  describe "#record" do
    it "returns a array of the top dna with fitness" do
      expect(population.record).to be_an_instance_of(Array)
    end
  end

end
