module.exports =

  announcer: 1

  descriptions:
	 count:
		  title: 'count'
   battery:
      title: 'battery voltage'
      min: 0
      max: 5000
      factor: 100 / 1024 
      scale: 0
   ldr:
      title: 'Light intensity'
      min: 0
      max: 100
      factor: 100 / 1024 
      scale: 0
   tempemperature:
      title: 'Temperature'
      unit: '°C'
      scale: 1
      min: -50
      max: 50

  feed: 'rf12.packet'

  decode: (raw, cb) ->
    t = raw.readUInt16LE(3, true)
    l = raw.readUInt16LE(5, true)
    b = raw.readUInt16LE(7, true)
    console.log "hello"
    cb
      battery:  b
      ldr: l
      temperature:  t
