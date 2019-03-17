cmake_minimum_required(VERSION 2.8)

if(NOT DEFINED CMAKE_TOOLCHAIN_FILE)
  if(DEFINED ENV{VITASDK})
    set(CMAKE_TOOLCHAIN_FILE "$ENV{VITASDK}/share/vita.toolchain.cmake" CACHE PATH "toolchain file")
  else()
    message(FATAL_ERROR "Please define VITASDK to point to your SDK path!")
  endif()
endif()

project(snake)
include("${VITASDK}/share/vita.cmake" REQUIRED)

set(VITA_APP_NAME "LameCraft")
set(VITA_DISP_NAME "LameCraft Vita")
set(SHORT_NAME LameCraft)
set(VITA_TITLEID  "LAMECRAFT")
set(VITA_VERSION  "01.00")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
set(VITA_MKSFOEX_FLAGS "${VITA_MKSFOEX_FLAGS} -d PARENTAL_LEVEL=1")

include_directories(
  ../common
	include
)

link_directories(
  ${CMAKE_CURRENT_BINARY_DIR}
)

add_executable(${VITA_APP_NAME}
  source/Aurora/Utils/Timer.cpp
  source/Aurora/Utils/StateManager.cpp
  Lamecraft.cpp
)

target_link_libraries(${VITA_APP_NAME}
  SceLibKernel_stub

  SceDisplay_stub
)

vita_create_self(${SHORT_NAME}.self ${SHORT_NAME})
vita_create_vpk(${SHORT_NAME}.vpk ${VITA_TITLEID} ${SHORT_NAME}.self
  VERSION ${VITA_VERSION}
  NAME ${VITA_DISP_NAME}

  #FILE sce_sys/icon0.png 									      sce_sys/icon0.png
  #FILE sce_sys/pic0.png 									      sce_sys/pic0.png
  #FILE sce_sys/livearea/contents/bg.png 				sce_sys/livearea/contents/bg.png
  #FILE sce_sys/livearea/contents/startup.png 		sce_sys/livearea/contents/startup.png
  #FILE sce_sys/livearea/contents/template.xml 	sce_sys/livearea/contents/template.xml
)