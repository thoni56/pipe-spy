# Compile pipe-spy

# This is the target to exec...
TARGET=possibly/relative/path/to/the/actual/target
# ... with the full path...
TARGET_PATH=`python -c "import os,sys; print(os.path.realpath(os.path.expanduser('$(TARGET)')))" "${1}"`

pipe-spy:
	$(CC) -o pipe-spy -g -Wall -DTARGET=\"$(TARGET_PATH)\" pipe-spy.c
