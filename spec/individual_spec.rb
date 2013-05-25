require "spec_helper"

describe Individual do
  let(:genome_length){10}
  let(:individual){Individual.new(genome_length)}

  
  describe "#set_DNA" do
    let(:dna){individual.set_dna}

    it "has DNA" do
      expect(dna).to be_an_instance_of(Array)
    end

    it "Dna is a array of 0's or 1's" do
      dna.each do |gene|
        expect([0,1]).to include(gene)
      end
    end

    it "sets dna to length of genome_legth" do
      expect(dna.length).to eql(genome_length)
    end
  end

  describe "#set_fitness" do
    let(:fitness_param){(1..genome_length).map{|gene| rand(2)}}
    let(:fitness){individual.set_fitness(fitness_param)}
    let(:dna){individual.set_dna}

    it "sets a fitness score" do
      expect(fitness).to be_an_instance_of(Fixnum)
    end

    it "is dependent on fitness_param" do
      test_fitness = 0
      dna.each_with_index do |gene,index|
        test_fitness +=1 if gene == fitness_param[index]
      end
      expect(fitness).to eql(test_fitness)
    end
  end

  describe "#mutate" do
    let(:old_dna){individual.dna.dup}
    let(:new_dna){individual.mutate.dup}
    it "inverts the dna" do
      expect(old_dna).to_not eql(new_dna)
    end
  end

  describe "#new" do
    let(:test_individual){Individual.new(genome_length)}

    it "sets the dna"do
      expect(test_individual.dna).to_not be_nil
    end
  end

end