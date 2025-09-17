with import (fetchTarball("https://github.com/NixOS/nixpkgs/archive/f72be405a10668b8b00937b452f2145244103ebc.tar.gz")) { };
let 
  buildInputs = (with pkgs; [
    openmpi
    clang
    llvm
    python3
    llvmPackages_15.libcxx
    # llvmPackages_15.libcxxabi
  ]);
in
mkShell {
  # name = "mpi-test-shell";
  buildInputs = buildInputs;
  OMPI_MPICC="clang";
  OMPI_CXX="clang++";
  
  LIBC = "${stdenv.cc.libc}";

  GCC = "${stdenv.cc.cc}";

  # where to find libgcc
  # OMPI_LDFLAGS="-L${pkgs.stdenv.cc.libc}/lib -L${pkgs.stdenv.cc.cc}/lib/gcc/${pkgs.targetPlatform.config}/${pkgs.stdenv.cc.cc.version}";
  # # teach clang about C startup file locations
  # OMPI_CFLAGS="-B${pkgs.stdenv.cc.cc}/lib/gcc/${pkgs.targetPlatform.config}/${pkgs.stdenv.cc.cc.version} -B ${pkgs.stdenv.cc.libc}/lib";
  # OMPI_CFLAGS="-static";
  OMPI_CFLAGS="-fsanitize=memory -fsanitize-recover=memory";
  OMPI_CXXFLAGS="-fsanitize=memory -fsanitize-recover=memory -std=c++17 -DHAVE_SESSION -DHAVE_COUNT -DHAVE_PCOLL -DHANDLE_COMM";
  PMIX_MCA_gds="hash";
  OMPI_MCA_memory="^patcher";
  MSAN_SYMBOLIZER_PATH="${pkgs.llvm}/bin/llvm-symbolizer";
}
