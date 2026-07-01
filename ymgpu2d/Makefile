# Auto-detect nvcc: prefer PATH, then scan common cuda-12.x installs
NVCC      := $(shell which nvcc 2>/dev/null || ls /usr/local/cuda-1[2-9].*/bin/nvcc 2>/dev/null | sort -V | tail -1)
CXX_FLAGS := -std=c++17 -O2 -lineinfo
CUDA_FLAGS := --expt-relaxed-constexpr

# Detect GPU compute capability; fall back to sm_70
COMPUTE   := $(shell nvidia-smi --query-gpu=compute_cap --format=csv,noheader 2>/dev/null | head -1 | tr -d '.')
ARCH      := $(if $(COMPUTE),sm_$(COMPUTE),sm_70)

SRCS   := main_ym.cu YM_Fluid.cu YM_Init.cu YM_Energy.cu YM_FCT.cu YM_Physics.cu FCT_Sweeps.cu
TARGET := ym_coupled

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(SRCS) YM_Common.cuh YM_Fluid.cuh YM_Init.cuh YM_Energy.cuh YM_FCT.cuh YM_Physics.cuh FCT_Kernels.cuh FCT_DeviceMath.cuh
	$(NVCC) $(CXX_FLAGS) $(CUDA_FLAGS) -arch=$(ARCH) $(SRCS) -o $(TARGET)
	@echo "Built $(TARGET) for arch $(ARCH)"

clean:
	rm -f $(TARGET)
