exports.info =
  name: 'moteino'
  description: 'Serial interface for a Motino running tmp102 sketch'
  inputs: [
    name: 'Serial port'
    default: 'ttyUSB0' # TODO: list choices with serialport.list
  ]
  # events: ['rf12.packet', 'data']
  # dependencies:
  #   'serialport': '*'

serialport = require 'serialport'
state = require '../server/state'

class RF12demo extends serialport.SerialPort

  constructor: (device) ->
    info = {}
    ainfo = {}

    console.log("before port: "+device)
    # support some platform-specific shorthands
    switch process.platform
      when 'darwin' then port = device.replace /^usb-/, '/dev/tty.usbserial-'
      when 'linux'  then port = device.replace /^tty/, '/dev/tty'
      else port = device

    console.log("after port: "+port)
    console.log("process.platform: "+process.platform)
    # FIXME open with delay to work around an FTDI serial kernel bug (!)
    setTimeout =>
      # construct the serial port object
      super port,
        baudrate: 115200
        parser: serialport.parsers.readline '\n'
    , 1000

    @on 'data', (data) ->
      data = data.slice(0, -1)  if data.slice(-1) is '\r'
      state.emit 'incoming', 'moteino', device, data
      words = data.split ' '
      state.emit 'rf12.other', words[1]
      console.log(words[1])

  destroy: -> @close()

exports.factory = RF12demo

