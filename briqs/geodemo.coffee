exports.info =
  name: 'geodemo'
  description: 'jeenode for DS18B20 and LDR'
  menus: [
    title: 'geoDemo'
    controller: 'GeoDemoCtrl'
  ]

state = require '../server/state'
ss = require 'socketstream'

exports.factory = class

  constructor: ->
    state.on 'rf12.packet', packetListener

  destroy: ->
    state.off 'rf12.packet', packetListener

#struct  {int c,t,b,l;} 
s = "packet buffer "
packetListener = (packet, ainfo) ->
  for i in packet.buffer
    s +=  " " + i
  console.log(s)

  if packet.id is 1 and packet.group is 212
    count = packet.buffer[2]*256+packet.buffer[1]
    temperature = ((packet.buffer[4]*256+packet.buffer[3])/10.0)*1.8+32.0
    battery = packet.buffer[6]*256+packet.buffer[5]
    ldr = packet.buffer[8]*256+packet.buffer[7]
    console.log("count ="+count)
    console.log("temperature ="+temperature)
    console.log("battery ="+battery)
    console.log("ldr ="+ldr)

    ss.api.publish.all 'ss-geodemo', count,temperature,ldr,battery


#/^OK/ { printf("%d %2.1f %d %d\n", $4*256+$3,(($6*256+$5)/10.0)*1.8+32.0,($8*256+$7),$10*256+$9);}
