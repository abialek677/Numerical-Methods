CXX := g++
CXXFLAGS := -O3 -flto=auto -fomit-frame-pointer -finline-functions -funroll-loops -ftree-vectorize -march=native -ffast-math -fuse-linker-plugin
SRCS := matrixClass.cpp operators.cpp computationMethods.cpp func.cpp linearEquations.cpp
TARGET := main

# Section for profile data generation
profile-generate: CXXFLAGS += -fprofile-generate
profile-generate: $(SRCS)
	$(CXX) $(CXXFLAGS) $^ -o $(TARGET)-generate

# Section for profile data usage
profile-use: CXXFLAGS += -fprofile-use
profile-use: $(SRCS)
	$(CXX) $(CXXFLAGS) $^ -o $(TARGET)-use

# Section for running the code
run: $(TARGET)
	./$(TARGET)

clean:
	rm -f $(TARGET) $(TARGET)-generate $(TARGET)-use
