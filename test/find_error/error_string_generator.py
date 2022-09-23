#!/usr/bin/env python3

#    The MIT License (MIT)
#    Copyright (c) Kiyo Chinzei (kchinzei@gmail.com)
#    Permission is hereby granted, free of charge, to any person obtaining a copy
#    of this software and associated documentation files (the "Software"), to deal
#    in the Software without restriction, including without limitation the rights
#    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#    copies of the Software, and to permit persons to whom the Software is
#    furnished to do so, subject to the following conditions:
#    The above copyright notice and this permission notice shall be included in
#    all copies or substantial portions of the Software.
#    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#    THE SOFTWARE.

REQUIRED_PYTHON_VERSION = (3, 0)

import sys
import re

def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)

def parse_crerror_h(crerror_h, outfile):
    with open(outfile, 'w') as fout:
        fout.write('#ifndef _CRERROR_STRING_H_ \n')
        fout.write('#define _CRERROR_STRING_H_ \n')
        fout.write('#include <string> \n')
        fout.write('namespace SCRSDK { \n')
        fout.write('  typedef struct { CrError errnum; const std::string errstr; } CrError_String; \n')
        fout.write('  const CrError_String kCrError_Strings[] = { \n')
        # CrError.h contains non-utf-8 char, seems shift-jis.
        with open(crerror_h, encoding='shift_jis') as fin:
            for s in fin:
                match = re.match(r'		(Cr[A-Za-z0-9_]*)', s)
                if match:
                    err_code = match.group(1)
                    fout.write(f'    {{{err_code}, "{err_code}"}}, \n')

        fout.write('  }; \n')
        fout.write('} // end of namespace \n')
        fout.write('#endif // _CRERROR_STRING_H_ \n')

def main():
    if sys.version_info < REQUIRED_PYTHON_VERSION:
        eprint(f'Requires python {REQUIRED_PYTHON_VERSION} or newer.')
        return 1
    if len(sys.argv) != 3:
        eprint(f'Usage: {sys.argv[0]} path_to_CrError.h output.h')
        return 1

    parse_crerror_h(sys.argv[1], sys.argv[2])
    return 0

if __name__ == '__main__':
    sys.exit(main())
