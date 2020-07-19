-- premake5.lua
workspace "deadmiles"
   configurations { "Debug", "Release" }

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

group "Dependencies"
   include "vendor/glfw"

project "deadmiles"
   kind "ConsoleApp"
   language "C++"
   targetdir ("bin/" .. outputdir .. "/%{prj.name}")
   objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

   files { "src/**.h", "src/**.cpp" }

   includedirs {
      "vendor/glfw/include"
   }

   filter "system:windows"
      links {
         "GLFW",
         "OpenGL32"
      }

   filter "system:macosx"
      links {
         "GLFW",
         "Cocoa.framework",
         "OpenGL.framework",
         "IOKit.framework",
         "CoreVideo.framework"
      }

   filter "configurations:Debug"
      defines { "DEBUG" }
      symbols "On"

   filter "configurations:Release"
      defines { "NDEBUG" }
      optimize "On"