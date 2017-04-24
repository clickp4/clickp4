import os

if __name__ == '__main__':
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
