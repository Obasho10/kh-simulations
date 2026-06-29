NVCC      := nvcc
CXX_FLAGS := -std=c++17 -O2 -lineinfo
CUDA_FLAGS := --expt-relaxed-constexpr

# Detect GPU compute capability (e.g. "8.6" -> "sm_86"). Falls back to sm_70.
COMPUTE   := $(shell nvidia-smi --query-gpu=compute_cap --format=csv,noheader 2>/dev/null | head -1 | tr -d '.')
ARCH      := $(if $(COMPUTE),sm_$(COMPUTE),sm_70)

SRCS      := main_coupled.cu EMHD_Physics.cu FCT_Sweeps.cu
TARGET    := emhd_coupled

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(SRCS) EMHD_Physics.cuh FCT_Kernels.cuh FCT_DeviceMath.cuh
	$(NVCC) $(CXX_FLAGS) $(CUDA_FLAGS) -arch=$(ARCH) $(SRCS) -o $(TARGET)
	@echo "Built with GPU arch: $(ARCH)"

clean:
	rm -f $(TARGET)
	rm -rf coupled_out
