local dfpwm = require("cc.audio.dfpwm")
local speaker = peripheral.find("speaker")
local decoder = dfpwm.make_decoder()
local handle = assert(http.get("https://uploadnow.io/f/wbFf5sc", nil, true))

for chunk in handle.read, 16 * 1024 do
    local buffer = decoder(chunk)
    while not speaker.playAudio(buffer) do
        os.pullEvent("speaker_audio_empty")
    end
end

handle.close()