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

  describe "#set_species" do
    let(:species){population.set_species}
    it " is an array of individuals"do
      expect(species).to be_an_instance_of(Array)
      species.each do |individual|
        expect(individual).to be_an_instance_of(Individual)
        expect(individual.dna).to_not be_nil
      end
    end
  end

  describe "#set_fitness" do
    let(:species) do 
      population.set_species 
      population.set_fitness 
    end

    it "sets a fitness level for individuals" do
      species.each do |individual|
        expect(individual.fitness).to be > 0
      end
    end
  end

  describe "#sort_by_fitness" do
    let(:fitness_param){(1..genome_length).map{|gene| rand(2)}}
    let(:species) do 
      population.set_species 
      population.set_fitness
      population.sort_by_fitness
    end

    it "the first individual has the highest fitness" do
      previous = species[0]
      species.each do |individual|
        expect(individual.fitness).to be <= (previous.fitness)
        previous = individual
      end
    end
  end

  describe "#selection" do
    let (:new_population_size){(population_size/2).round}
    let (:new_species) do 
      population.set_species 
      population.set_fitness
      population.sort_by_fitness
      population.selection
    end
    it "remove least fit half of the species" do
      expect(new_species.size).to eql(new_population_size)
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
    let(:species){population.reproduce}
    it "increases the population by 100%" do
      expect(species.size).to eql(population_size*2)
      species.each do |individual|
        expect(individual).to be_an_instance_of(Individual)
      end
    end
  end
  describe "#mutate" do

    let(:old_dna_set) do
      old_dna_set =[] 
      population.species.each do |dna|
        old_dna_set<<dna
      end
      old_dna_set
    end
    it "randomly changes the genes of individuals"do
      population.mutate
      new_dna_set = []
      population.species.each do|individual|
        new_dna_set << individual.dna
      end
      expect(new_dna_set).to_not eql(old_dna_set)
    end
    
  end

end
