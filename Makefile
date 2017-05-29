SWITCH_DIR=/home/netarchlab/bmv2/targets/simple_switch
CONTROLLER_DIR=/home/netarchlab/odb/router
CONTROLLER_IP=101.6.30.157
CONTROLLER_PORT=40123
INTF=-i 1@peth1 -i 2@peth2
LOG=-L off
COMMANDS1=commands1
COMMANDS=commands
#LOG=--log-console

compile:
	@mkdir -p build >>/dev/null
	@python tools/parse_config.py
	@p4c-bmv2 src/clickp4.p4 --json build/clickp4.json

run: compile
	@cp build/clickp4.json $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&sudo bash simple_switch clickp4.json $(INTF) $(LOG)
	# -- --controller-ip=$(CONTROLLER_IP) --controller-port=$(CONTROLLER_PORT) 

populate-l3:
	@cp test/l3_switch/commands $(SWITCH_DIR)
	@cp test/l3_switch/modules config/modules
	@make compile
	@cp build/clickp4.json $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&sudo bash simple_switch clickp4.json $(INTF) $(LOG) 
	# -- --controller-ip=$(CONTROLLER_IP) --controller-port=$(CONTROLLER_PORT) 

populate-init:
	@cp test/l3_switch/commands-init $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&./runtime_CLI <commands-init

populate-plus-eth:
	@cp test/l3_switch/commands-plus-eth $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&./runtime_CLI <commands-plus-eth
	
populate-plus-ipv4:
	@cp test/l3_switch/commands-plus-ipv4 $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&./runtime_CLI <commands-plus-ipv4

populate-plus-tcp:
	@cp test/l3_switch/commands-plus-tcp $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&./runtime_CLI <commands-plus-tcp

populate-plus-udp:
	@cp test/l3_switch/commands-plus-udp $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&./runtime_CLI <commands-plus-udp

populate-rewind:
	@cp test/rewinder/commands $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&./runtime_CLI <commands

populate-redundant:
	@cp test/redundant/commands $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&./runtime_CLI <commands


run-exp1:
	@cp test/l3_switch/commands $(SWITCH_DIR)
	@cp test/l3_switch/modules config/modules
	@make compile
	@cp build/clickp4.json $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&sudo bash simple_switch clickp4.json $(INTF) $(LOG) 
	# -- --controller-ip=$(CONTROLLER_IP) --controller-port=$(CONTROLLER_PORT) 

run-exp2:
	@cp test/chain0/commands $(SWITCH_DIR)
	@cp test/chain0/modules config/modules
	@make compile
	@cp build/clickp4.json $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&sudo bash simple_switch clickp4.json $(INTF) $(LOG) 
	# -- --controller-ip=$(CONTROLLER_IP) --controller-port=$(CONTROLLER_PORT) 

run-exp3:
	@cp test/chain1/commands $(SWITCH_DIR)
	@cp test/chain1/modules config/modules
	@make compile
	@cp build/clickp4.json $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&sudo bash simple_switch clickp4.json $(INTF) $(LOG) 
	# -- --controller-ip=$(CONTROLLER_IP) --controller-port=$(CONTROLLER_PORT) 

run-exp4:
	@cp test/chain4/commands $(SWITCH_DIR)
	@cp test/chain4/modules config/modules
	@make compile
	@cp build/clickp4.json $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&sudo bash simple_switch clickp4.json $(INTF) $(LOG) 
	# -- --controller-ip=$(CONTROLLER_IP) --controller-port=$(CONTROLLER_PORT) 

run-linear2: compile
	@cp build/clickp4.json $(SWITCH_DIR)
	@cd tools&&bash linear-2.sh

run-linear3: compile
	@cp build/clickp4.json $(SWITCH_DIR)
	@cd tools&&bash linear-3.sh

run-linear4: compile
	@cp build/clickp4.json $(SWITCH_DIR)
	@cd tools&&bash linear-4.sh

run-linear5: compile
	@cp build/clickp4.json $(SWITCH_DIR)
	@cd tools&&bash linear-5.sh

run-linear6: compile
	@cp build/clickp4.json $(SWITCH_DIR)
	@cd tools&&bash linear-6.sh

run-linear7: compile
	@cp build/clickp4.json $(SWITCH_DIR)
	@cd tools&&bash linear-7.sh

run-linear8: compile
	@cp build/clickp4.json $(SWITCH_DIR)
	@cd tools&&bash linear-8.sh

populate-linear2:
	@cp test/redundant/commands $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&./runtime_CLI <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9091 <commands

populate-linear3:
	@cp test/redundant/commands $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&./runtime_CLI <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9091 <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9092 <commands

populate-linear4:
	@cp test/redundant/commands $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&./runtime_CLI <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9091 <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9092 <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9093 <commands

populate-linear5:
	@cp test/redundant/commands $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&./runtime_CLI <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9091 <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9092 <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9093 <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9094 <commands

populate-linear6:
	@cp test/redundant/commands $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&./runtime_CLI <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9091 <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9092 <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9093 <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9094 <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9095 <commands

populate-linear7:
	@cp test/redundant/commands $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&./runtime_CLI <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9091 <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9092 <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9093 <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9094 <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9095 <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9096 <commands

populate-linear8:
	@cp test/redundant/commands $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&./runtime_CLI <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9091 <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9092 <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9093 <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9094 <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9095 <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9096 <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9097 <commands


populate-redundant-linear1:
	@cp test/linear/commands $(SWITCH_DIR)
	@cp test/linear/$(COMMANDS1) $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&./runtime_CLI <$(COMMANDS)

populate-redundant-linear2:
	@cp test/linear/commands $(SWITCH_DIR)
	@cp test/linear/$(COMMANDS1) $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&./runtime_CLI <$(COMMANDS)
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9091 <$(COMMANDS1)

populate-redundant-linear3:
	@cp test/linear/commands $(SWITCH_DIR)
	@cp test/linear/$(COMMANDS1) $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&./runtime_CLI <$(COMMANDS)
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9091 <$(COMMANDS1)
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9092 <$(COMMANDS1)

populate-redundant-linear4:
	@cp test/linear/commands $(SWITCH_DIR)
	@cp test/linear/$(COMMANDS1) $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&./runtime_CLI <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9091 <$(COMMANDS1)
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9092 <$(COMMANDS1)
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9093 <$(COMMANDS1)

populate-redundant-linear5:
	@cp test/linear/commands $(SWITCH_DIR)
	@cp test/linear/$(COMMANDS1) $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&./runtime_CLI <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9091 <$(COMMANDS1)
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9092 <$(COMMANDS1)
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9093 <$(COMMANDS1)
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9094 <$(COMMANDS1)

populate-redundant-linear6:
	@cp test/linear/commands $(SWITCH_DIR)
	@cp test/linear/$(COMMANDS1) $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&./runtime_CLI <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9091 <$(COMMANDS1)
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9092 <$(COMMANDS1)
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9093 <$(COMMANDS1)
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9094 <$(COMMANDS1)
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9095 <$(COMMANDS1)

populate-redundant-linear7:
	@cp test/linear/commands $(SWITCH_DIR)
	@cp test/linear/$(COMMANDS1) $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&./runtime_CLI <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9091 <$(COMMANDS1)
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9092 <$(COMMANDS1)
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9093 <$(COMMANDS1)
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9094 <$(COMMANDS1)
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9095 <$(COMMANDS1)
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9096 <$(COMMANDS1)

populate-redundant-linear8:
	@cp test/linear/commands $(SWITCH_DIR)
	@cp test/linear/$(COMMANDS1) $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&./runtime_CLI <commands
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9091 <$(COMMANDS1)
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9092 <$(COMMANDS1)
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9093 <$(COMMANDS1)
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9094 <$(COMMANDS1)
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9095 <$(COMMANDS1)
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9096 <$(COMMANDS1)
	@cd $(SWITCH_DIR)&&./runtime_CLI --thrift-port 9097 <$(COMMANDS1)



populate-exp4:
	@cd $(SWITCH_DIR)&&./runtime_CLI <commands

list:
	@echo "ClickP4 Modules:"
	@cat config/modules
	@echo

clean:
	@rm -rf build

install-bmv2:
	@bash tools/install_bmv2.sh

setup-veth:
	@bash tools/setup_veth.sh

setup-peth:
	@bash tools/setup_peth.sh

clear-peth:
	@bash tools/clear_peth.sh

clear-veth:
	@bash tools/clear_veth.sh

nic-offload:
	@bash tools/disable_nic_offload.sh

