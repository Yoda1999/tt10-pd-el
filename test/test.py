# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")
    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())
    
    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1
    
    dut._log.info("Test project behavior")
    
    # TEST 1: 0 + 0 + 0 = 0, carry = 0
    dut.ui_in.value = 0b00000000  # a=0, b=0, cin=0
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 0b00000000
    
    # TEST 2: 1 + 0 + 0 = 1, carry = 0
    dut.ui_in.value = 0b00000001  # a=1, b=0, cin=0
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 0b00000001
    
    # TEST 3: 1 + 1 + 0 = 0, carry = 1
    dut.ui_in.value = 0b00000011  # a=1, b=1, cin=0
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 0b00000010
    
    # TEST 4: 1 + 1 + 1 = 1, carry = 1
    dut.ui_in.value = 0b00000111  # a=1, b=1, cin=1
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 0b00000011
    
    # TEST 5: 0 + 1 + 1 = 0, carry = 1
    dut.ui_in.value = 0b00000110  # a=0, b=1, cin=1
    await ClockCycles(dut.clk, 1)
    assert dut.uo_out.value == 0b00000010
