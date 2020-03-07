# pipe-spy

<<<<<<< HEAD
A C-program that can be injected between two processes to spy on their communcation over pipes.

## Use case

I had a situation where one program exec:ed another and communicated
bi-directionally over pipes. As I was interested in learning the
details of this communication I wanted to spy in that conversation.

## Alternatives

Actually I could not find any alternatives here. [My question](https://stackoverflow.com/questions/59937720/how-to-inject-logging-of-communication-over-pipes) on
stackoverflow did not get any answers and googling found none either.

I'm happy to add some alternatives here, if you'd like to share.

(Of course there is always `strace` but that just generates a lot of
extra information that was in the way.)

So I implemented this little utility.

## Usage

You have to find a way to get the `caller` to exec `pipe-spy` instead
of the actual `target`. You compile this source and place it or
soft-link in a place where your caller will find it, thinking it is
the real program it calls.

The way I used it was to create a link to `pipe-spy` with the same
name as the actual target but in a directory that was earlier in the
PATH. This might not always be possible, so YMMV.

You can specify the real target either as a compile-time constant

    $(CC) -DTARGET=<target> ...

or as an environment variable:

    TARGET=<target> <command-that-invokes-pipe-spy>

If the `caller` tries to exec the actual `target` this utility will
instead be run. It will in turn exec the `target` and spy and log the
downstream and upstream communication in a file.

This file is by default `/tmp/pipe-spyPID.log`, but you can change
where that logging goes using an environment variable:

    LOGFILE=<logfile> <command-that-invokes-pipe-spy>


## Implementation

`pipe-spy` forks three processes, two for the up- / down-stream
communication and one that execs the actual `target`.

The complicated part is to set up the pipes correctly.

## Improvements

- The handling of closed pipes is probably not correct, so if your
`caller` closes the communication `pipe-spy` will probably hang.

- The path to the `target` now has to be compiled in. Any ideas on how
  to do avoid this are most welcome (note that we can't use command
  line arguments, since the requirement is that the `caller` cannot be
  changed).

PR:s are welcome.
=======
A C-program that can be injected between two processes to spy on thier
communcation over pipes.


You also have to tell `pipe-spy` which program it should invoke so
that the communication can be established, creating a
man-in-the-middle setup where `pipe-spy` is the man in the middle.

You can define the TARGET either through a compile-time constant:
