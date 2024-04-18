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
    dut.sw.value = False
    dut.enter.value = False

    # multi
    dut.operation.value = 0

    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)
    dut.rst.value = False

    await FallingEdge(dut.clk)

    dut.data_in.value = 255

    dut.enter.value = True
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)
    dut.enter.value = False
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)


    dut.enter.value = True
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)
    dut.enter.value = False
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)



    dut.enter.value = True
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)
    dut.enter.value = False
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)



    dut.enter.value = True
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)
    dut.enter.value = False
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)



    dut.enter.value = True
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)
    dut.enter.value = False
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)



    dut.enter.value = True
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)
    dut.enter.value = False
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)


    dut.enter.value = True
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)
    dut.enter.value = False
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)



    dut.enter.value = True
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)
    dut.enter.value = False
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)


    assert dut.finish.value == 0
    assert dut.error.value == 0

    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)
    assert dut.finish.value == 0
    await FallingEdge(dut.clk)


    assert dut.finish.value == 1
    assert dut.error.value == 0
    print(dut.data_out.value)
    print(dut.index.value)


    dut.sw.value = True
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)
    dut.sw.value = False
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)

    
    print(dut.data_out.value)
    print(dut.index.value)

    dut.sw.value = True
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)
    dut.sw.value = False
    await FallingEdge(dut.clk)
    await FallingEdge(dut.clk)

    
    print(dut.data_out.value)
    print(dut.index.value)

