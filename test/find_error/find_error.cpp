/*
  The MIT License (MIT)
  Copyright (c) Kiyo Chinzei (kchinzei@gmail.com)
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:
  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
*/
/*
  This sample is based on SDK's RemoteCli.cpp
 */
#include <iostream>
#include <cstdlib>
#include "CameraRemote_SDK.h"
#include "error_string.h"

namespace SDK = SCRSDK;

int main(int argc, const char** argv)
{
    if (argc <= 1) {
        std::cerr << "Usage: " << argv[0] << " errno [errno ...]\n";
        std::cerr << "Display error definition in CrError.h from given error number(s)\n";
        std::cerr << "Camera not necessary to be connected.\n";
    }
    
    for (int i=1; i<argc; i++) {
        int errnum = std::atoi(argv[i]);
        int siz = sizeof(SDK::kCrError_Strings);
        for (int j=0; j< siz; j++) {
            const SDK::CrError_String *p = &SDK::kCrError_Strings[j];
            if (p->errnum == errnum) {
                std::cout << "Error [" << errnum << "] = [" << p->errstr << "]\n";
            }
        }
    }
    return 0;            
}
