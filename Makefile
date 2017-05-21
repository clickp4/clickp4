SWITCH_DIR=/home/netarchlab/onos-p4-dev/onos-bmv2/targets/simple_switch
CONTROLLER_DIR=/home/netarchlab/odb/router
CONTROLLER_IP=101.6.30.157
CONTROLLER_PORT=40123
INTF=-i 1@veth3 -i 2@veth4
LOG=-L off

compile:
	@mkdir -p build >>/dev/null
	@python tools/parse_config.py
	@p4c-bmv2 src/clickp4.p4 --json build/clickp4.json

run:
	@cp test/l3_switch/modules config/modules
	@make json
	@cp build/clickp4.json $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&sudo bash simple_switch clickp4.json $(INTF) $(LOG) -- --controller-ip=$(CONTROLLER_IP) --controller-port=$(CONTROLLER_PORT) 


run-exp1:
	@cp test/l3_switch/commands $(SWITCH_DIR)
	@cp test/l3_switch/modules config/modules
	@make json
	@cp build/clickp4.json $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&sudo bash simple_switch clickp4.json $(INTF) $(LOG) -- --controller-ip=$(CONTROLLER_IP) --controller-port=$(CONTROLLER_PORT) 

run-exp2:
	@cp test/chain0/commands $(SWITCH_DIR)
	@cp test/chain0/modules config/modules
	@make json
	@cp build/clickp4.json $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&sudo bash simple_switch clickp4.json $(INTF) $(LOG) -- --controller-ip=$(CONTROLLER_IP) --controller-port=$(CONTROLLER_PORT) 

run-exp3:
	@cp test/chain1/commands $(SWITCH_DIR)
	@cp test/chain1/modules config/modules
	@make json
	@cp build/clickp4.json $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&sudo bash simple_switch clickp4.json $(INTF) $(LOG) -- --controller-ip=$(CONTROLLER_IP) --controller-port=$(CONTROLLER_PORT) 

run-exp4:
	@cp test/chain4/commands $(SWITCH_DIR)
	@cp test/chain4/modules config/modules
	@make json
	@cp build/clickp4.json $(SWITCH_DIR)
	@cd $(SWITCH_DIR)&&sudo bash simple_switch clickp4.json $(INTF) $(LOG) -- --controller-ip=$(CONTROLLER_IP) --controller-port=$(CONTROLLER_PORT) 

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