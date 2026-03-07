if {[file exists "work"]} {vdel -all}
vlib work

# Compile
vlog -sv -f dut.f
vlog -sv -f tb.f

# Optimize with coverage
vopt top -o top_opt +acc +cover=bcesf

# Simulate 
vsim top_opt -coverage +UVM_TESTNAME=random_test
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
# Save coverage database
coverage save random_test.ucdb


# Simulate 
vsim top_opt -coverage +UVM_TESTNAME=add_test
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
# Save coverage database
coverage save add_test.ucdb


# Coverage reports
vcover merge alu.ucdb random_test.ucdb add_test.ucdb
vcover report alu.ucdb -cvg -details




quit -f