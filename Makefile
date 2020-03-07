# Build a pipe-spy
#
# You can define the TARGET either through a compile-time constant:
#
# $(CC) -DTARGET=<target> ...
#
# or as an environment variable:
#
# TARGET=<target> <command-that-invokes-pipe-spy>
#
# Pipe-spy logs the interaction in a file /tmp/pipespy*.log, but you
# can change that using an environment variable:
#
# LOGFILE=<logfile> <command-that-invokes-pipe-spy>
#
pipe-spy: pipe-spy.c Makefile
	$(CC) -o pipe-spy -g -Wall pipe-spy.c
