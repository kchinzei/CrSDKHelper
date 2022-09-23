/*
  This sample is based on SDK's RemoteCli.cpp
 */
#include <iostream>
#include "CameraRemote_SDK.h"

namespace SDK = SCRSDK;

int main()
{
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

  SDK::Release();
  std::exit(EXIT_SUCCESS);
}
