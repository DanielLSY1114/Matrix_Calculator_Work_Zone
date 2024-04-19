import os
import logging
import random
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import *



@cocotb.test()
async def basic_test(dut):
    print("============== STARTING Basic TEST ==============")

    # Run the clock
    cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())

    # Since our circuit is on the rising edge,
    # we can feed inputs on the falling edge
    # This makes things easier to read and visualize
    await FallingEdge(dut.clk)

    # Reset the DUT
    dut.rst.value = True
    dut.add_en.value = False
    dut.sign.value = False
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)
    dut.rst.value = False

    await FallingEdge(dut.clk)

    dut.mat_A.value = 18446744073709551615
    dut.mat_B.value = 18446744073709551615

    dut.add_en.value = True
    assert dut.finish.value == 0

    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)
    print(dut.finish.value)

    assert dut.finish.value == 1

    print ("output: ", dut.mat_out.value)
    A = int(dut.mat_out.value)
    binary_str = bin(A)[2:].zfill(160)

    chunks = [binary_str[i:i+10] for i in range(0, len(binary_str), 10)]

    elements = [int(chunk, 2) for chunk in chunks]

    print("output: ", elements)

