if {[file exists "work"]} {vdel -all}
vlib work

# Compile
vlog -sv -f dut.f
vlog -sv -f tb.f

# Optimize with coverage
vopt top -o top_opt +acc +cover=bcesf

# Simulate 
vsim top_opt -coverage +UVM_TESTNAME=fibonacci_test
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
# Save coverage database
coverage save fibonacci_test.ucdb


# Simulate 
vsim top_opt -coverage +UVM_TESTNAME=parallel_test 
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
# Save coverage database
coverage save parallel_test.ucdb

# Simulate 
vsim top_opt -coverage +UVM_TESTNAME=full_test 
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
# Save coverage database
coverage save full_test.ucdb


# Coverage reports
vcover merge alu.ucdb fibonacci_test.ucdb parallel_test.ucdb full_test.ucdb
vcover report alu.ucdb -cvg -details




quit -f