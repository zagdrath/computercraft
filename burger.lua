local dfpwm = require("cc.audio.dfpwm")

local speaker = peripheral.find("speaker")
local decoder = dfpwm.make_decoder()

while true do
    os.pullEvent("redstone")

    if rs.getInput("front") then
        for chunk in io.lines("burger.dfpwm"), 16 * 1024 do
            local buffer = decoder(chunk)

            while not speaker.playAudio(buffer, 3.0) do
                os.pullEvent("speaker_audio_empty")
            end
        end

        os.sleep(1)
    end

    os.sleep(1)
end
