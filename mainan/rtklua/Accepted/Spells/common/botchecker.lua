botchecker = {
    cast = function(player)
        -- Membuat soal matematika sederhana
        local num1 = math.random(1, 10) -- Angka pertama (1-10)
        local num2 = math.random(1, 10) -- Angka kedua (1-10)
        local operator = "+" -- Operator matematika (bisa diubah ke "-", "*", atau "/")
        local answer = num1 + num2 -- Menghitung jawaban yang benar

        -- Menyimpan jawaban yang benar di data pemain
        player:setData("mathAnswer", answer)

        -- Menampilkan pop-up dengan soal matematika kepada pemain
        player:popUp("<b>Silakan selesaikan soal matematika ini untuk membuktikan bahwa Anda bukan bot:\n\n" .. num1 .. " " .. operator .. " " .. num2 .. " = ?\n\nAnda memiliki waktu 180 detik untuk menjawab. Jika gagal, karakter Anda akan dijail.")
        player:setDuration("botchecker", 195000) -- Set durasi pemeriksaan (195 detik)
        characterLog.bottingLog(
            player,
            "Pemeriksaan bot dimulai untuk " .. player.name
        )
    end,

    while_cast = function(player)
        -- Mengirim pengingat kepada pemain pada interval tertentu
        if player:getDuration("botchecker") == 180000 then -- Setelah 3 menit
            player:msg(0, "Pengingat pertama: Selesaikan soal matematika untuk menghindari dijail.", player.ID)
        end
        if player:getDuration("botchecker") == 120000 then -- Setelah 2 menit
            player:msg(0, "Pengingat kedua: Selesaikan soal matematika untuk menghindari dijail.", player.ID)
        end
        if player:getDuration("botchecker") == 60000 then -- Setelah 1 menit
            player:msg(0, "Pengingat terakhir: Selesaikan soal matematika sekarang atau Anda akan dijail.", player.ID)
        end
    end,

    uncast = function(player)
        -- Memeriksa jawaban pemain setelah durasi pemeriksaan berakhir
        local playerAnswer = tonumber(player:getData("mathAnswerInput")) -- Mengambil jawaban pemain
        local correctAnswer = tonumber(player:getData("mathAnswer")) -- Mengambil jawaban yang benar

        if playerAnswer == correctAnswer then
            -- Jika jawaban benar, bebaskan pemain
            player:unlock()
            characterLog.bottingLog(
                player,
                player.name .. " berhasil menjawab soal matematika dan telah dibebaskan."
            )
        else
            -- Jika jawaban salah atau tidak ada jawaban, pindahkan pemain ke jail
            player:warp(666, 3, 4) -- Memindahkan pemain ke jail
            player:unlock()
            characterLog.bottingLog(
                player,
                player.name .. " dipindahkan ke jail karena gagal menjawab soal matematika."
            )
        end
    end
}

-- Command untuk memungkinkan pemain memasukkan jawaban mereka
commands.addCommand("answer", function(player, args)
    local answer = tonumber(args[1]) -- Mengambil jawaban dari input pemain
    if answer then
        -- Menyimpan jawaban pemain di data pemain
        player:setData("mathAnswerInput", answer)
        player:msg(0, "Jawaban Anda telah direkam.", player.ID)
    else
        -- Menangani input yang tidak valid
        player:msg(0, "Input tidak valid. Harap masukkan angka.", player.ID)
    end
end)