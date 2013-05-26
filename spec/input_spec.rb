require "spec_helper"

describe Input do
  let(:input){Input.new 0,0,0,0,0}

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

  describe "#set_generation_count"do
    let(:invalid_number){-1}
    let(:valid_number){10}
    context "if count is <1" do
      it "will be set to 20" do
        expect(input.set_generation_count(invalid_number)).to eql(20)
      end
    end
   it "will set the count as inputed" do
      expect(input.set_generation_count(valid_number)).to eql 10
   end
  end

  describe "#set_population_size" do
    context "user inputs >2" do
      let(:invalid_number){1}
      it "the value will be 20" do
        expect(input.set_population_size invalid_number).to eql 20
      end
    end
  end

  describe "#check_for_array" do
    let(:valid_array){[]}
    let(:invalid_array) { 1 }
    it "checks if fitness_param is an array" do
      expect(input.check_for_array(valid_array)).to be_true
      expect(input.check_for_array(invalid_array)).to be_false
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

  describe "#set_fitness_param" do
    context "if input is not valid" do
      let(:invalid_arrays){[[1,0],[1,nil,0],[1,0,0,'a'],1]}
      it "will generate one"do
        invalid_arrays.each do |invalid|
          new_array = input.set_fitness_param invalid
          expect(new_array).to be_an_instance_of(Array)
          expect(new_array.length).to eql(input.genome_length)
        end
      end
    end
    let(:valid_array) {(1..input.genome_length).map{|gene| rand(2)}}
    it "will set it be @fitness param" do
      expect(input.set_fitness_param valid_array).to eql(valid_array)
    end
  end

  describe "#storage" do
    
  end

end