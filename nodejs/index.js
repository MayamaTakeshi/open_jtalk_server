var express = require('express')
var spawn = require('child_process').spawn
var uuid = require('uuid')
var request = require('request')
var logger = require('./logger.js')

const config = require('config')

var app = express()

app.get('/text_to_speech', function(req, res) {
	var req_uuid = req.query.uuid

    if(!req_uuid) {
       req_uuid = uuid.v4()
    } 

	logger.log('info', `${req_uuid}: ${req.method} request for /text_to_speech received: ${req.url}`)

	if(req.method == 'HEAD') {
		res.setHeader('Cache-Control', 'max-age=31536000')
		res.status(200).end()
		return
	}

	var voice = req.query.voice
	if(!voice) {
		var error = 'Parameter voice is missing'
		logger.log('error', `${req_uuid}: ${error}`)
		res.status(400).send(error)
		return
	}

	var text = req.query.text
	if(!text) {
		var error = 'Parameter text is missing'
		logger.log('error', `${req_uuid}: ${error}`)
		res.status(400).send(error)
		return
	}

	var voice_file
	var shell

	text = unescape(text)

    switch(voice) {
    case 'm001':
        res.setHeader('Content-Type', 'audio/wav')
        voice_file = '../assets/hts_voice_nitech_jp_atr503_m001-1.05/nitech_jp_atr503_m001.htsvoice'
        shell = spawn(process.cwd() + "/open_jtalk_wrapper.sh",  [text, voice_file, config.WORKING_FOLDER + "/" + req_uuid + ".wav"])
        shell.stdout.pipe(res)
        break
    case 'mei_angry':
    case 'mei_bashful':
    case 'mei_happy':
    case 'mei_normal':
    case 'mei_sad':
        res.setHeader('Content-Type', 'audio/wav')
        var mei_base_folder = '../assets/MMDAgent_Example-1.8/Voice/mei/'
        voice_file = mei_base_folder + voice + ".htsvoice"
        shell = spawn(process.cwd() + "/open_jtalk_wrapper.sh",  [text, voice_file, config.WORKING_FOLDER + "/" + req_uuid + ".wav"])
        shell.stdout.pipe(res)
        break
    default:
        var error = `Invalid voice=${voice}`
        logger.log('error', `${req_uuid}: ${error}`)
        res.status(400).send(error)
	}
})


app.listen(config.LOCAL_PORT, config.LOCAL_IP_ADDRESS)
logger.log('info', 'Listening on ' + config.LOCAL_IP_ADDRESS + ":" + config.LOCAL_PORT)

