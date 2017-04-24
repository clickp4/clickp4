import os

def parse_modules():
    config = open('src/config/modules', 'r')
    module = open('src/include/module.p4', 'w')
    module.write('#ifndef __CLICK_MODULE__\n')
    module.write('#define __CLICK_MODULE__\n\n')
    print('Compiling modules into ClickP4:')
    for m in config:
        module.write('#include \"../module/%s.p4\"\n'%(m))
    i = 1

    module.write('\n\n');

    config.seek(0)
    for m in config:
        print('Module %d : %s'%(i, m))
        if not os.path.exists('src/module/%s.p4'%(m)):
            print 'Cannot find fiels of %s\n'%(m)
            exit(1)

        module.write('#define MODULE_%d module_%s()\n'%(i, m))
        i = i + 1

    config.close()

    module.write('\n\n#endif\n')
    module.close()

def parse_context():
    config = open('src/config/context', 'r')
    module = open('src/include/context.p4', 'w')
    module.write('#ifndef __CLICK_CONTEXT__\n')
    module.write('#define __CLICK_CONTEXT__\n\n')
    print('Loading context:')
    i = 1
    for m in config:
        if not os.path.exists('src/context/%s.p4'%(m)):
            print 'Cannot find fiels of %s\n'%(m)
            exit(1)
        print('Module %d : %s'%(i, m))
        module.write('#include \"../context/%s.p4\"\n'%(m))
        i = i + 1

    config.close()
    module.write('\n\n#endif\n')
    module.close()


if __name__ == '__main__':
    parse_context()
    parse_modules()
