"""

"""

import whatreallyhappened as wrh


def main():
    wrh.open('out.txt', 'w')
    wrh.push('testing')
    wrh.log('myvariable', 'another x=%d', 123)
    wrh.pop('done %s', 'finally')

    wrh.push('another push')
    wrh.log('magic', '%s', 'value')
    wrh.push('nested')
    info = wrh.save()
    print(f'{info = }')
    wrh.log('k2', '%s', 'v2')
    wrh.pop('pop')
    wrh.pop('pop2')

    wrh.load(info)
    wrh.push('a2')
    wrh.log('k3', '%s', 'v3')
    wrh.pop('a2')


def cli():
    import argparse

    parser = argparse.ArgumentParser()
    args = vars(parser.parse_args())

    main(**args)


if __name__ == '__main__':
    cli()
