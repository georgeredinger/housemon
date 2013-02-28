module.exports =

  announcer: 1

  descriptions:
    ping:
      title: 'Ping count'
      min: 0
    age:
      title: 'Estimated age'
      unit: 'days'
      min: 0

  feed: 'rf12.packet'

  decode: (raw, cb) ->
    count = raw.readUInt32LE(1)
    cb
      ping: 1
      age: 31416
  
 
