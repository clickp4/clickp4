SWITCH_DIR=/home/netarchlab/bmv2/targets/simple_switch
CONTROLLER_DIR=/home/netarchlab/odb/router
CONTROLLER_IP=101.6.30.157
CONTROLLER_PORT=40123
INTF=-i 1@peth1 -i 2@peth2
LOG=-L off
# LOG=--log-console

compile:
	@mkdir -p build >>/dev/null
	@python tools/parse_config.py
	@p4c-bmv2 src/clickp4.p4 --json build/clickp4.json

run:
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
