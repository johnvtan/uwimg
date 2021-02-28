OPENCV=0
OPENMP=0
DEBUG=0
VERBOSE=0

OBJ=image_opencv.o load_image.o process_image.o args.o filter_image.o resize_image.o test.o harris_image.o matrix.o panorama_image.o flow_image.o list.o data.o classifier.o
EXOBJ=main.o

VPATH=./src/:./:./src/hw0:./src/hw1:./src/hw2:./src/hw3:./src/hw4:./src/hw5:./src/hw6:./src/hw7
SLIB=libuwimg.so
ALIB=libuwimg.a
EXEC=uwimg
OBJDIR=./obj/

CC=zig cc
CPP=zig c++
ZIG=zig build-obj
AR=ar
ARFLAGS=rcs
OPTS=-Ofast
ZOPTS=-O ReleaseSafe
LDFLAGS= -lm -pthread 
COMMON= -Iinclude/ -Isrc/ 
CFLAGS=-Wall -Wno-unknown-pragmas -Wfatal-errors -fPIC
ZFLAGS=--single-threaded -fPIC -target x86_64-linux-musl --library c --enable-cache --cache-dir $(OBJDIR) 

ifeq ($(OPENMP), 1) 
CFLAGS+= -fopenmp
endif

ifeq ($(DEBUG), 1) 
OPTS=-O0 -g
ZOPTS=-O Debug
COMMON= -Iinclude/ -Isrc/ 
else
CFLAGS+= 
endif

CFLAGS+=$(OPTS)

ifeq ($(OPENCV), 1) 
COMMON+= -DOPENCV
CFLAGS+= -DOPENCV
LDFLAGS+= `pkg-config --libs opencv4` -lstdc++  # This may vary depending on your OpenCV version
COMMON+= `pkg-config --cflags opencv4`
endif

EXOBJS = $(addprefix $(OBJDIR), $(EXOBJ))
OBJS = $(addprefix $(OBJDIR), $(OBJ))
DEPS = $(wildcard src/*.h) Makefile 

all: obj $(EXEC)
alib: obj $(ALIB)
slib: obj $(SLIB)

$(EXEC): $(EXOBJS) $(OBJS)
	rm -rf $(OBJDIR)/o $(OBJDIR)/h
	$(CC) $(COMMON) $(CFLAGS) $^ -o $@ $(LDFLAGS) 

$(ALIB): $(OBJS)
	rm -rf $(OBJDIR)/o $(OBJDIR)/h
	$(AR) $(ARFLAGS) $@ $^

$(SLIB): $(OBJS)
	rm -rf $(OBJDIR)/o $(OBJDIR)/h
	$(CC) $(CFLAGS) -shared $^ -o $@ $(LDFLAGS)

$(OBJDIR)%.o: %.c $(DEPS)
	$(CC) $(COMMON) $(CFLAGS) -c $< -o $@

$(OBJDIR)%.o: %.cpp $(DEPS)
	$(CPP) $(COMMON) $(CFLAGS) -c $< -o $@

$(OBJDIR)%.o: %.zig $(DEPS)
	$(ZIG) $(COMMON) $(ZFLAGS) $<
	cd $(OBJDIR) && find . -name '*.o' -exec mv {} . \;


obj:
	mkdir -p obj

.PHONY: clean

clean:
	rm -rf $(OBJS) $(SLIB) $(ALIB) $(EXEC) $(EXOBJS) $(OBJDIR)/*

