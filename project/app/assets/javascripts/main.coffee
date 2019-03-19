# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


document.addEventListener 'DOMContentLoaded', (event) ->
  monitSwitch = document.getElementById('monitSwitch')
  if monitSwitch
    console.log ' monitSwitch status: ', monitSwitch.checked  
    monitSwitch.addEventListener 'change', (event) ->
      console.log ' monitSwitch changed: ', monitSwitch.checked , '[current value]'

      if monitSwitch.checked
          xhttp = new XMLHttpRequest

          xhttp.onreadystatechange = ->
            if @readyState == 4 and @status == 200 
              monitSwitch.checked = !!xhttp.responseText.res
            return
          xhttp.open 'GET', 'http://localhost:8000/stop', true
          xhttp.send()
      else 
        xhttp = new XMLHttpRequest

        xhttp.onreadystatechange = ->
          if @readyState == 4 and @status == 200 
            monitSwitch.checked = !!xhttp.responseText.res
          return
        xhttp.open 'GET', 'http://localhost:8000/start', true
        xhttp.send()

      monitSwitch.checked = !monitSwitch.checked
      return


  checkStatus = ->
    xhttp = new XMLHttpRequest

    xhttp.onreadystatechange = ->
      if @readyState == 4 and @status == 200 
        monitSwitch.checked = !!xhttp.responseText.res
      return
    xhttp.open 'GET', 'http://localhost:8000/status', true
    xhttp.send()

    return

  setInterval checkStatus, 1000

  path = '/updates'
  wshost = 'ws://localhost:8000'

  # socket = io 'http://localhost:8000', path: '/updates'
  # socket.on 'hello', (msg) ->
  #   console.log 'socket', msg
  #   return

  client = new (nes.Client)(wshost)

  # Set an onConnect listener & connect to the service
  connected = false

  client.onConnect = ->
    if connected
      return
    connected = true
    console.log 'connected'
    return

  client.connect {}, (err) ->
  client.subscribe path, (msg) ->
    console.log 'wesocket msg ', msg
    monitSwitch.checked = !!msg.res
    return



  return
