#
# called "nodeMap-local.coffee". For example, if you use group 212:
#
#   exports.rf12nodes = 
#     212:
#       1: 'roomNode'
#       2: ...etc
#
# The settings in the local file will be merged (and can override) the settings
# in this file. If you override settings, the "replay" briq may no longer work.

fs = require 'fs'

# this is still used for parsing logs which do not include announcer packets
# TODO: needs to be time-dependent, since the config can change over time
exports.rf12nodes =
  5:
    2: 'roomNode'
    3: 'radioBlip'
    4: 'roomNode'
    5: 'roomNode'
    6: 'roomNode'
    9: 'homePower'
    10: 'roomNode'
    11: 'roomNode'
    12: 'roomNode'
    13: 'roomNode'
    14: 'otRelay'
    15: 'smaRelay'
    18: 'p1scanner'
    19: 'ookRelay'
    20: 'slowLogger'
    23: 'roomNode'
    24: 'roomNode'
  # included for the DIJN LDR example
  100:
    1: 'lightNode'

# devices are mapped to RF12 configs, since that is not present in log files
# TODO: same time-dependent comment as above, this mapping is not fixed
# this section is only used by the 'rf12-replay' briq
exports.rf12devices =
  'ttyUSB0':
    recvid: 1
    group: 212
    band: 915

# static data, used for local testing and for replay of the JeeLabs data
# these map incoming sensor identifiers to locations in the house (in Dutch)
exports.locations =
  'RF12:212:1': title: 'geoNode'

	
