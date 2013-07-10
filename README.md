Genetic_algorithm
=================
This just a demo of genetic algorithms
Sorry for the rough nature, I am currently working on making this a command line tool.

The runner is the input.rb file

Initialize
`Input.new(genome_length, population_size, fitness_param, generation_count)`

Variables
==========
+  genome length is how long the DNA, an array of 0,1, is
+  population size is how big the intial size of the population
+  fitness param is the 'ideal' DNA sequence
+  generation count is how many generations the program will run

If the variables are too low, the default is 20 for each variable


To run
`input.run`

Outputs


`input.record`
Will return the record from all generations

`input.best_fit`
Will return the most "fit" from each generation


BostonRB project night presentation can be found [here](https://docs.google.com/presentation/d/1C_bpFpV1lGyUNXcC5krNIiPVCo6tWNt9bnKvUxD2qDI/edit#slide=id.p)
