require "spec_helper"

describe Input do
  let(:input){Input.new 0,0,0,0}

  describe "#new" do
  end

  describe "#set_genome_length" do
    context "user inputs a number less 2 or nil" do
      it "will set value to 20"do
        expect(input.genome_length).to eql 20
      end
    end
    context "user input a number greater than 2" do
     before :each do
      input.set_genome_length 30
    end
      it "will set it to that value" do 
        expect(input.genome_length).to eql 30
      end
    end
  end

  describe "#check_for_array" do
    it "checks if fitness_param is an array" do
      expect(input.check_for_array([])).to be_true
      expect(input.check_for_array(1)).to be_false
    end
  end

  describe "#check_for_validity" do
    let(:invalid_array){[1,0,0,'a']}
    let(:invalid_array_2){[1,nil,0]}
    let(:valid_array){[1,0,1,0]}
    it "checks if the array consists of 0 or 1" do
      expect(input.check_for_validity invalid_array).to be_false
      expect(input.check_for_validity invalid_array_2).to be_false
      expect(input.check_for_validity valid_array).to be_true
    end
  end

  describe "#check_for_length" do
    let(:genome_length){20}
    let(:invalid_array){[1,0]}
    let(:valid_array){(1..genome_length).map{|gene| rand(2)}}
    it "check if fitnes_param is the same length as the genome" do
      expect(input.check_for_length(valid_array)).to be_true
      expect(input.check_for_length(invalid_array)).to be_false
    end
  end

end