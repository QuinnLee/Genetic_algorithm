require "spec_helper"

describe Individual do
  let(:genome_legth){10}
  
  describe "#make DNA" do
    it "has DNA" do
      expect(individual.dna).to be_an_instance_of(Array)
      individual.dna each do |gene|
        expect([0,1]).to include(gene)
      end
    end
  end

end