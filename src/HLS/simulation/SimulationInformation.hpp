#ifndef SIMULATION_INFORMATION_HPP
#define SIMULATION_INFORMATION_HPP

#include "refcount.hpp"

#include <cstddef>
#include <map>
#include <string>
#include <vector>

REF_FORWARD_DECL(SimulationTool);

class SimulationInformation
{
 public:
   /// every element of this vector maps the parameters of the top function
   //  to be tested onto strings representing their values for in a certain
   //  test vector
   std::vector<std::map<std::string, std::string>> test_vectors;

   /// filename for cosimulation
   std::string filename_bench;

   /// reference to the simulation tool
   SimulationToolRef sim_tool;

   /// The fields below are used only by the legacy (bambu 2023.1) XML testbench generator
   /// (--testbench-style=legacy|both).

   /// true when the XML test vectors carry expected outputs (param:output,
   /// param:init_output_file or return attributes)
   bool results_available = false;

   /// for a given test vector index, this map gives the address map of the
   //  parameters of the top function to be tested
   std::map<unsigned int, std::map<unsigned int, unsigned long long int>> param_address;

   /// for a given test vector index, this map gives, for every parameter
   //  index, the total size of the memory reserved for it
   std::map<unsigned int, std::map<unsigned int, size_t>> param_mem_size;

   /// for a given test vector index, this map gives, for every parameter
   //  index, the offset (in bytes) of the position of the next aligned byte
   std::map<unsigned int, std::map<unsigned int, size_t>> param_next_off;

   /// store the list of parameter name of the function under test
   std::vector<std::string> simulationArgSignature;
};

using SimulationInformationRef = refcount<SimulationInformation>;
using SimulationInformationConstRef = refcount<const SimulationInformation>;
#endif
