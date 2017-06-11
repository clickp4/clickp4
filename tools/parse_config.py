import os

def parse_modules():
    config = open('config/modules', 'r')
    module = open('src/core/module.p4', 'w')
    module.write('#ifndef __CLICK_MODULE__\n')
    module.write('#define __CLICK_MODULE__\n\n')
    print('Compiling modules into ClickP4:')
    for m in config.readlines():
        m = m.strip('\n')
        if not os.path.exists('src/module/%s.p4'%(m)):
            print 'Cannot find files of %s\n'%(m)
            exit(1)
        module.write('#include \"../module/%s.p4\"\n'%(m))
    i = 1

    module.write('\n\n');

    config.seek(0)
    for m in config:
        m = m.strip('\n')
        print('Module %d : %s'%(i, m))
        module.write('#define MODULE_%d module_%s()\n'%(i, m))
        i = i + 1

    config.close()

    module.write('\n\n#endif\n')
    module.close()

def parse_context():
    config = open('config/context', 'r')
    context = open('src/core/context.p4', 'w')
    context.write('#ifndef __CLICK_CONTEXT__\n')
    context.write('#define __CLICK_CONTEXT__\n\n')
    print('Loading context:')
    i = 1
    for m in config.readlines():
        m = m.strip('\n')
        if not os.path.exists('src/context/%s.p4'%(m)):
            print 'Cannot find files of %s\n'%(m)
            exit(1)
        print('Context %d : %s'%(i, m))
        context.write('#include \"../context/%s.p4\"\n'%(m))
        i = i + 1

    config.close()
    context.write('\n\n#endif\n')
    context.close()

def parse_protocol():
    config = open('config/protocol', 'r')
    protocol = open('src/core/protocol.p4', 'w')
    protocol.write('#ifndef __CLICK_PROTOCOL__\n')
    protocol.write('#define __CLICK_PROTOCOL__\n\n')
    print('Loading protocols:')

    i = 1
    start = ''
    protocols = []
    for m in config.readlines():
        m = m.strip('\n')
        if not os.path.exists('src/protocol/%s.p4'%(m)):
            print 'Cannot find files of %s\n'%(m)
            exit(1)
        if i == 1:
            start = m

        protocols.append(m)
        print('Protocol %d : %s'%(i, m))
        i = i + 1
        
    while protocols:
        protocol.write('#include \"../protocol/%s.p4\"\n'%(protocols.pop()))

    protocol.write('\n\nparser start {\n')
    protocol.write('\treturn parse_%s;\n'%(start))
    protocol.write('}\n')

    config.close();
    protocol.write('\n#endif\n')
    protocol.close()

if __name__ == '__main__':
    parse_context()
    parse_modules()
    parse_protocol()
