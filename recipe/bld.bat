@echo on

set "AZURE_SDK_DISABLE_AUTO_VCPKG=ON"

cd sdk\core\azure-core

REM The SDK root resets CMAKE_CXX_STANDARD; set only this library target.
echo set_property(TARGET azure-core PROPERTY CXX_STANDARD 17)>>CMakeLists.txt
if errorlevel 1 exit 1

mkdir build
cd build
cmake %CMAKE_ARGS% ^
  -G Ninja ^
  -D CMAKE_CXX_STANDARD=17 ^
  -D BUILD_SHARED_LIBS=ON ^
  -D BUILD_TRANSPORT_WINHTTP=ON ^
  ..
if %ERRORLEVEL% neq 0 exit 1

cmake --build . --target install --config Release
if %ERRORLEVEL% neq 0 exit 1
