import os
import numpy as np
import math
import atexit
import readline

clear = lambda : os.system('clear') or None

# Don't save history
readline_history_file = os.path.join(os.path.expanduser('~'), '.python_history')
try:
    readline.read_history_file(readline_history_file)
except IOError:
    pass

readline.set_history_length(0)
atexit.register(readline.write_history_file, readline_history_file)
