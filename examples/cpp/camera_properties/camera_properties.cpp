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
  Display camera properties
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <iostream>
#include "CameraRemote_SDK.h"

namespace SDK = SCRSDK;

int main(int argc, char **argv)
{
  int camera_index = 0;
  errno = 0;

  if (argc >= 2)
    camera_index = strtod(argv[1], NULL);

  auto init_success = SDK::Init();
  if (!init_success) {
    std::cerr << "Failed to initialize Remote SDK. Terminating.\n";
    SDK::Release();
    std::exit(EXIT_FAILURE);
  }
  SDK::ICrEnumCameraObjectInfo* camera_list = nullptr;
  auto enum_status = SDK::EnumCameraObjects(&camera_list);
  if (CR_FAILED(enum_status) || camera_list == nullptr) {
    std::cerr << "No cameras detected. Connect a camera and retry.\n";
    SDK::Release();
    std::exit(EXIT_FAILURE);
  }
  auto ncams = camera_list->GetCount();
  std::cout << "Camera enumeration successful. " << ncams << " detected.\n\n";

  if (camera_index >= ncams) {
    std::cerr << "Camera ID should be smaller than " << ncams << ". Terminating\n";
    SDK::Release();
    std::exit(EXIT_FAILURE);
  }
  
  auto camera_info = camera_list->GetCameraObjectInfo(camera_index);
  auto conn_type = camera_info->GetConnectionTypeName();
  auto model = camera_info->GetModel();
  if ("IP" == conn_type) {
    cli::NetworkInfo ni = cli::parse_ip_info(camera_info->GetId(), camera_info->GetIdSize());
    id = ni.mac_address;
  }
  else id = ((TCHAR*)camera_info->GetId());
  std::cout << model << " (" << id << ")\n";

  SDK::Release();
  std::exit(EXIT_SUCCESS);
}
