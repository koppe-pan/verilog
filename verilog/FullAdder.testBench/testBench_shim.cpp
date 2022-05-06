#include <cstdlib>

#include <verilated.h>

#include "VtestBench.h"

int main(int argc, char **argv) {
  Verilated::commandArgs(argc, argv);

  VtestBench *top = new VtestBench;

  while(!Verilated::gotFinish()) {
    top->eval();
  }

  top->final();

  delete top;

  return EXIT_SUCCESS;
}

