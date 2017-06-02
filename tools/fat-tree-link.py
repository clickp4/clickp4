#! /bin/python
import os


class Host:
    def __init__(self, hid):
        self.id = hid
        self.name = "h%d"%hid
        self.p = None

    def start(self):
        print 'Create Host: %s '%self.name
        if self.check() == 1:
            self.destroy()
        os.system('ip netns add %s'%self.name)

    def destroy(self):
        os.popen('ip netns del %s'%self.name)

    def check(self):
        c = os.popen('ip netns list')
        for i in c.readlines():
            if i.strip('\n') == self.name:
                return 1
        return 0

    def cmd(self, cmd):
        os.system("ip netns exec %s %s"%(self.name, cmd))

    def popen_cmd(self, cmd):
        if self.p is not None:
            self.p.wait()
        self.p = os.popen("ip netns exec %s %s"%(self.name, cmd))


DEFAULT_EXE = '/home/netarchlab/bmv2/targets/simple_switch/simple_switch'


class Switch:
    def __init__(self, sid, config_file, exe=DEFAULT_EXE):
        self.id = sid
        self.name = 's%d'%sid
        self.port = sid + 9090
        self.conf_file = config_file
        self.exe = exe
        self.log = '-L off'
        self.interfaces = []

    def start(self):
        cmd =['/bin/bash', self.exe, self.conf_file, self.log, '--thrift-port', self.port]
        c = 1
        for i in self.interfaces:
            cmd.append('-i')
            cmd.append('%d@%s'%(c, i))
            c += 1
        str = ''
        for i in cmd:
            str = "%s %s"%(str, i)
        self.p = os.popen(str)

    def add_intf(self, nic):
        os.system('sudo ifconfig %s up promisc'%nic)
        self.interfaces.append(nic)

    def wait(self):
        if self.p is not None:
            self.p.wait()


def create_link(peer1, peer2):
    os.popen("ip link add %s type veth peer name %s"%(peer1, peer2))


def main():
    create_link('e1_1', 'a1_1')
    create_link('e1_2', 'a2_2')
    create_link('e2_1', 'a2_1')
    create_link('e2_2', 'a1_2')
    create_link('e3_1', 'a3_1')
    create_link('e3_2', 'a4_2')
    create_link('e4_1', 'a4_1')
    create_link('e4_2', 'a3_2')
    create_link('c1_1', 'a1_3')
    create_link('c1_2', 'a3_3')
    create_link('c2_1', 'a2_3')
    create_link('c2_2', 'a4_3')


if __name__ == "__main__":
    main()
