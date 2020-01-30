# pipe-spy

A C-program that can be injected between two processes to spy on their communcation over pipes.

## Use case

I had a situation where one program exec:ed another and communicated
bi-directionally over pipes. As I was interested in learning the
details of this communication I wanted to spy in that conversation.

## Alternatives

Actually I could not find any alternatives here. My question on
stackoverflow did not get any answers and googling found none either.

I'm happy to add some alternatives here, if you'd like to share.

(Of course there is always `strace` but that just generates a lot of
extra information that was in the way.)

So I implemented this little utility.

## Usage

Set the TARGET variable (environment or Makefile) to point to the
actual `target` and compile.

Then you have to find a way to get the `caller` to exec this instead of the
actual `target`. The way I used it was to create a link to `pipe-spy`
with the same name as the actual target but in a directory that was
earlier in the PATH. This might not always be possible, so YMMV.

If the `caller` tries to exec the actual `target` this utility will
instead be run. It will in turn exec the `target` and spy and log the
downstream and upstream communication in a file
(`/tmp/pipe-spyPID.log`).

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
